import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:goat_challenge/src/common/goat_challenges_consts.dart';
import 'package:goat_challenge/src/detail/detail_page_controller.dart';
import 'package:goat_challenge/src/detail/services/detail_book_service.dart';
import 'package:goat_challenge/src/detail/widgets/detail_app_bar.dart';
import 'package:goat_challenge/src/detail/widgets/detail_section_with_list.dart';
import 'package:goat_challenge/src/detail/widgets/detail_section_with_value.dart';
import 'package:goat_challenge/src/detail/widgets/detail_summary.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatelessWidget {
  final int id;

  const DetailPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tag = "$id";

    Get.lazyPut(() => DetailBookService());
    Get.lazyPut(() => DetailPageController(), tag: tag);

    final controller = DetailPageController.of(tag);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: controller.obx(
          (book) {
            if (book == null) return const Center(child: Text("Not found"));

            return SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const DetailAppBar(),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15.h),
                      child: DetailSummary(
                        tag: tag,
                        id: id,
                        title: book.title,
                        imageUrl: book.formats.imageJpeg ??
                            GoatChallengeConsts.emptyImageLink,
                        author: book.authors.isNotEmpty
                            ? book.authors.first.name
                            : null,
                        languages: book.languages,
                      ),
                    ),
                    if (book.subjects.isNotEmpty)
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 7.h),
                        child: DetailSectionWithList(
                          title: "Subjects",
                          items: book.subjects,
                          onItemTap: (subject) => controller.findSimilarBooksBy(
                            subject: subject,
                          ),
                        ),
                      ),
                    if (book.bookshelves.isNotEmpty)
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 7.h),
                        child: DetailSectionWithList(
                          title: "Bookshelves",
                          items: book.bookshelves,
                          onItemTap: (bookshelf) =>
                              controller.findSimilarBooksBy(
                            bookshelf: bookshelf,
                          ),
                        ),
                      ),
                    if (book.authors.isNotEmpty)
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 7.h),
                        child: DetailSectionWithList(
                          title: "All Authors",
                          items: book.authors
                              .map((author) => author.name)
                              .toList(growable: false),
                          onItemTap: (author) => controller.findSimilarBooksBy(
                            author: author,
                          ),
                        ),
                      ),
                    if (book.translators.isNotEmpty)
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 7.h),
                        child: DetailSectionWithList(
                          title: "All Translators",
                          items: book.translators
                              .map((translator) => translator.name)
                              .toList(growable: false),
                        ),
                      ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 7.h),
                      child: DetailSectionWithValue(
                          title: "Copyright",
                          value: book.copyright ? "Yes" : "No"),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 7.h),
                      child: DetailSectionWithValue(
                        title: "Download Counts",
                        value:
                            NumberFormat.compact().format(book.downloadCount),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 7.h),
                      child: Center(
                        child: TextButton(
                          onPressed: controller.launchBookPreview,
                          child: const Text("Preview"),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          onLoading: const Center(
            child: CircularProgressIndicator(),
          ),
          onError: (error) => Center(
            child: Text(error ?? "Something went wrong"),
          ),
        ),
      ),
    );
  }
}
