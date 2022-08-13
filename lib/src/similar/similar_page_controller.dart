import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goat_challenge/src/route/goat_challenge_routes.dart';
import 'package:goat_challenge/src/similar/models/similar_book.dart';
import 'package:goat_challenge/src/similar/models/similar_search_book_result.dart';
import 'package:goat_challenge/src/similar/services/similar_book_service.dart';

class SimilarPageController extends GetxController
    with StateMixin<List<SimilarBook>> {
  static SimilarPageController of() => Get.find<SimilarPageController>();

  final _service = SimilarBookService.of();
  final _scrollController = ScrollController();

  SimilarSearchBookResult? _previousResult;
  bool _isRequestingNextBook = false;

  String get findBy {
    if (Get.parameters["author"] != null) {
      return "Author: ${Get.parameters["author"]!}";
    }

    if (Get.parameters["subject"] != null) {
      return "Subject: ${Get.parameters["subject"]!}";
    }

    if (Get.parameters["bookshelf"] != null) {
      return "Bookshelf: ${Get.parameters["bookshelf"]!}";
    }

    return "";
  }

  bool get hasMoreBooks => status.isLoadingMore;

  ScrollController get scrollController => _scrollController;

  @override
  void onInit() {
    super.onInit();

    final search = Get.parameters["author"] ?? "";
    final topic =
        Get.parameters["subject"] ?? Get.parameters["bookshelf"] ?? "";
    searchBooks(search: search, topic: topic);

    _initListener();
  }

  void goToBookDetail(int id) {
    print("id:$id");
    Get.toNamed(GoatChallengeRoutes.detail(id: id), preventDuplicates: false);
  }

  void searchBooks({String search = "", String topic = ""}) async {
    _clear();

    change([], status: RxStatus.loading());

    try {
      final response = await _service.searchBooks(search: search, topic: topic);
      if (response.hasError) {
        change([], status: RxStatus.error(response.bodyString));
        return;
      }

      final result = SimilarSearchBookResult.fromMap(response.body);

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
      change([], status: RxStatus.error(e.toString()));
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

    print("next: $next");

    try {
      final response = await _service.nextBooks(next);
      if (response.hasError) {
        change([], status: RxStatus.error(response.bodyString));
        return;
      }

      final result = SimilarSearchBookResult.fromMap(response.body);

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
  }

  void _clear() {
    _previousResult = null;
    _isRequestingNextBook = false;
  }
}
