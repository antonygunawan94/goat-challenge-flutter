import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:goat_challenge/src/common/goat_challenges_consts.dart';
import 'package:goat_challenge/src/main/main_page_controller.dart';
import 'package:goat_challenge/src/main/widgets/main_book.dart';

class MainBooks extends StatelessWidget {
  const MainBooks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainPageController = MainPageController.of();

    return mainPageController.obx(
      (books) {
        if (books == null) {
          return const SliverToBoxAdapter(child: Text("empty"));
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (mainPageController.hasMoreBooks && index == books.length) {
                return Center(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20.h),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              final book = books[index];

              var margin =
                  EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w);

              if (index == 0) {
                margin = EdgeInsets.only(
                    top: 10.h, bottom: 10.h, left: 15.w, right: 15.w);
              }

              if (index == books.length - 1) {
                margin = EdgeInsets.only(
                    top: 10.h, bottom: 20.h, left: 15.w, right: 15.w);
              }

              return Container(
                margin: margin,
                child: MainBook(
                  id: book.id,
                  title: book.title,
                  author: book.authors.isNotEmpty
                      ? book.authors.first.name
                      : "Unrecognized Author",
                  imageUrl: book.formats.imageJpeg ??
                      GoatChallengeConsts.emptyImageLink,
                  languages: book.languages,
                ),
              );
            },
            childCount:
                books.length + (mainPageController.hasMoreBooks ? 1 : 0),
          ),
        );
      },
      onLoading: SliverToBoxAdapter(
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 10.h),
            child: const CircularProgressIndicator(),
          ),
        ),
      ),
      onEmpty: const SliverToBoxAdapter(
        child: Text("emtpy"),
      ),
      onError: (error) =>
          const SliverToBoxAdapter(child: Text("Something went wrong")),
    );
  }
}
