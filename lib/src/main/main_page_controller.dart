import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goat_challenge/src/main/models/main_book.dart';
import 'package:goat_challenge/src/main/models/main_search_book_result.dart';
import 'package:goat_challenge/src/main/services/main_book_service.dart';
import 'package:goat_challenge/src/route/goat_challenge_routes.dart';

class MainPageController extends GetxController
    with StateMixin<List<MainBook>> {
  static MainPageController of() => Get.find<MainPageController>();

  final _service = MainBookService.of();
  final _scrollController = ScrollController();

  final _searchQuery = "".obs;

  MainSearchBookResult? _previousResult;
  bool _isRequestingNextBook = false;

  set searchQuery(String query) => _searchQuery.value = query;

  bool get hasMoreBooks => status.isLoadingMore;

  ScrollController get scrollController => _scrollController;

  @override
  void onInit() {
    super.onInit();
    searchBooks("");
    _initListener();
  }

  void goToBookDetail(int id) {
    Get.toNamed(GoatChallengeRoutes.detail(id: id));
  }

  void searchBooks(String query) async {
    _clear();

    change([], status: RxStatus.loading());

    try {
      final response = await _service.searchBooks(query);
      if (response.hasError) {
        change([], status: RxStatus.error(response.bodyString));
        return;
      }

      final result = MainSearchBookResult.fromMap(response.body);

      if (result.next == null) {
        if (result.books.isEmpty) {
          change([], status: RxStatus.empty());
          return;
        }

        change(result.books, status: RxStatus.success());
        return;
      }

      _previousResult = result;
      change(result.books, status: RxStatus.loadingMore());
    } on Exception catch (e) {
      change([], status: RxStatus.error("hello"));
    }
  }

  void nextBooks() async {
    if (_isRequestingNextBook) return;

    _isRequestingNextBook = true;

    var state = this.state ?? [];

    final previousResult = _previousResult;
    if (previousResult == null) {
      return;
    }

    final next = previousResult.next;
    if (next == null) {
      change(state, status: RxStatus.success());
      return;
    }

    try {
      final response = await _service.nextBooks(next);
      if (response.hasError) {
        change([], status: RxStatus.error(response.bodyString));
        return;
      }

      final result = MainSearchBookResult.fromMap(response.body);

      final newBooks = state + result.books;

      if (result.next == null) {
        change(newBooks, status: RxStatus.success());
        return;
      }

      _previousResult = result;
      change(newBooks, status: RxStatus.loadingMore());
    } on Exception catch (e) {
      change([], status: RxStatus.error(e.toString()));
    }

    _isRequestingNextBook = false;
  }

  void _initListener() {
    _scrollController.addListener(() {
      var nextPageTrigger = 0.8 * _scrollController.position.maxScrollExtent;

      if (_scrollController.position.pixels > nextPageTrigger) {
        nextBooks();
      }
    });

    debounce(_searchQuery, (_) => searchBooks(_searchQuery.value),
        time: const Duration(milliseconds: 700));
  }

  void _clear() {
    _previousResult = null;
    _isRequestingNextBook = false;
  }
}
