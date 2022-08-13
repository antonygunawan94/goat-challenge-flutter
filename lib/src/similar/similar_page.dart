import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:goat_challenge/src/similar/services/similar_book_service.dart';
import 'package:goat_challenge/src/similar/similar_page_controller.dart';
import 'package:goat_challenge/src/similar/widgets/similar_app_bar.dart';
import 'package:goat_challenge/src/similar/widgets/similar_books.dart';

class SimilarPage extends StatelessWidget {
  const SimilarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SimilarBookService());
    Get.lazyPut(() => SimilarPageController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 15.h, bottom: 7.h),
              child: const SimilarAppBar(),
            ),
            const Expanded(child: SimilarBooks()),
          ],
        ),
      ),
    );
  }
}
