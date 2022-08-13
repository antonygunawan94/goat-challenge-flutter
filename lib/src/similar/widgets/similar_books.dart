import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:goat_challenge/src/common/goat_challenges_consts.dart';
import 'package:goat_challenge/src/similar/similar_page_controller.dart';
import 'package:goat_challenge/src/similar/widgets/similar_book.dart';

class SimilarBooks extends StatelessWidget {
  const SimilarBooks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final similarPageController = SimilarPageController.of();

    return similarPageController.obx(
      (books) {
        if (books == null) return const Center(child: Text("Empty"));

        return ListView.builder(
          itemBuilder: (context, index) {
            if (similarPageController.hasMoreBooks && index == books.length) {
              return Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: 20.h),
                  child: const CircularProgressIndicator(),
                ),
              );
            }

            final book = books[index];

            var margin = EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w);

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
              child: SimilarBook(
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
          itemCount: books.length,
        );
      },
      onLoading: Center(
        child: Container(
          margin: EdgeInsets.only(top: 10.h),
          child: const CircularProgressIndicator(),
        ),
      ),
      onEmpty: const Center(child: Text("Empty")),
      onError: (error) => Text(error ?? "Something went wrong"),
    );
  }
}
