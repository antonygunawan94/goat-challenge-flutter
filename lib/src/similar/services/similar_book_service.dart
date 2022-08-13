import 'package:get/get.dart';

class SimilarBookService extends GetConnect {
  static SimilarBookService of() => Get.find<SimilarBookService>();

  Future<Response> searchBooks({String search = "", String topic = ""}) =>
      get("http://gutendex.com/books?search=$search&topic=$topic");

  Future<Response> nextBooks(String nextLink) => get(nextLink);
}
