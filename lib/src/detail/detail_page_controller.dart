import 'package:get/get.dart';
import 'package:goat_challenge/src/detail/models/detail_book.dart';
import 'package:goat_challenge/src/detail/services/detail_book_service.dart';
import 'package:goat_challenge/src/route/goat_challenge_routes.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPageController extends GetxController with StateMixin<DetailBook> {
  static DetailPageController of() => Get.find(tag: Get.parameters["id"]);

  final service = DetailBookService.of();

  DetailPageController();

  @override
  void onInit() {
    super.onInit();
    fetchBook();
  }

  void fetchBook() async {
    final id = Get.parameters["id"];
    if (id == null) {
      Get.toNamed(GoatChallengeRoutes.main);
      return;
    }

    change(null, status: RxStatus.loading());

    try {
      final response = await service.fetchBook(int.parse(id));

      if (response.hasError) {
        change(null, status: RxStatus.error(response.body["detail"]));
        return;
      }

      final book = DetailBook.fromMap(response.body);
      change(book, status: RxStatus.success());
    } on Exception catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  void findSimilarBooksBy(
      {String? author, String? subject, String? bookshelf}) {
    Get.toNamed(GoatChallengeRoutes.similar(
        author: author, subject: subject, bookshelf: bookshelf));
  }

  void launchBookPreview() async {
    if (!status.isSuccess) return;

    final state = this.state;

    if (state == null) return;

    final url = state.formats.textHtml ??
        state.formats.textHtmlCharsetUtf8 ??
        state.formats.textPlainCharsetUtf8 ??
        "";

    if (url.isEmpty) return;

    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }
}
