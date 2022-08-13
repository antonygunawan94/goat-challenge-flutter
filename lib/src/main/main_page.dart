import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:goat_challenge/src/main/main_page_controller.dart';
import 'package:goat_challenge/src/main/services/main_book_service.dart';
import 'package:goat_challenge/src/main/widgets/main_app_bar.dart';
import 'package:goat_challenge/src/main/widgets/main_books.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MainBookService());
    Get.lazyPut(() => MainPageController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          controller: MainPageController.of().scrollController,
          slivers: [
            MainAppBar(),
            const MainBooks(),
          ],
        ),
      ),
    );
  }
}
