import 'package:get/get.dart';

class MainBookService extends GetConnect {
  static MainBookService of() => Get.find<MainBookService>();

  Future<Response> searchBooks(String query) =>
      get("http://gutendex.com/books?search=$query");

  Future<Response> nextBooks(String nextLink) => get(nextLink);
}
