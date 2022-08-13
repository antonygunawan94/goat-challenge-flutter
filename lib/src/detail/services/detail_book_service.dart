import 'package:get/get.dart';

class DetailBookService extends GetConnect {

  static DetailBookService of() => Get.find();

  Future<Response> fetchBook(int id) => get("http://gutendex.com/books/$id");
}
