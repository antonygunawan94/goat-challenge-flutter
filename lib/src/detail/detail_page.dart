import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:goat_challenge/src/common/goat_challenges_consts.dart';
import 'package:goat_challenge/src/detail/detail_page_controller.dart';
import 'package:goat_challenge/src/detail/services/detail_book_service.dart';
import 'package:goat_challenge/src/detail/widgets/detail_summary.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DetailBookService());
    Get.lazyPut(() => DetailPageController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: DetailPageController.of().obx(
          (book) {
            if (book == null) return const Center(child: Text("Not found"));

            print(book.formats.textHtmlCharsetUtf8);

            return SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: IconButton(
                            onPressed: Get.back,
                            icon: const Icon(Icons.arrow_back),
                            visualDensity: VisualDensity.compact,
                          ),
                        ),
                        Text(
                          "Find out about",
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.black87,
                          ),
                        ),
                        Expanded(child: Container()),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15.h),
                      child: DetailSummary(
                        title: book.title,
                        imageUrl: book.formats.imageJpeg ??
                            GoatChallengeConsts.emptyImageLink,
                        author: book.authors.isNotEmpty
                            ? book.authors.first.name
                            : "Unrecognized Author",
                        languages: book.languages,
                      ),
                    ),
                    if (book.subjects.isNotEmpty)
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 7.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Subjects",
                              style: TextStyle(
                                fontSize: 15.8.sp,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 7.h),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemCount: book.subjects.length,
                                itemBuilder: (context, index) => Container(
                                  margin:
                                      EdgeInsets.symmetric(vertical: 2.25.h),
                                  child: Text(
                                    "· ${book.subjects[index]}",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    if (book.bookshelves.isNotEmpty)
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 7.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Bookshelves",
                              style: TextStyle(
                                fontSize: 15.8.sp,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 7.h),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemCount: book.bookshelves.length,
                                itemBuilder: (context, index) => Container(
                                  margin:
                                      EdgeInsets.symmetric(vertical: 2.25.h),
                                  child: Text(
                                    "· ${book.bookshelves[index]}",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    if (book.authors.isNotEmpty)
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 7.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "All Authors",
                              style: TextStyle(
                                fontSize: 15.8.sp,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 7.h),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemCount: book.authors.length,
                                itemBuilder: (context, index) => Container(
                                  margin:
                                      EdgeInsets.symmetric(vertical: 2.25.h),
                                  child: Text(
                                    "· ${book.authors[index].name}",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    if (book.translators.isNotEmpty)
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 7.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "All Authors",
                              style: TextStyle(
                                fontSize: 15.8.sp,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 7.h),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemCount: book.translators.length,
                                itemBuilder: (context, index) => Container(
                                  margin:
                                      EdgeInsets.symmetric(vertical: 2.25.h),
                                  child: Text(
                                    "· ${book.translators[index].name}",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 7.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Copyright",
                            style: TextStyle(
                              fontSize: 15.8.sp,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 7.h),
                            child: Text(
                              book.copyright ? "Yes" : "No",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 7.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Download Counts",
                            style: TextStyle(
                              fontSize: 15.8.sp,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 7.h),
                            child: Text(
                              NumberFormat.compact().format(book.downloadCount),
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 7.h),
                      child: Center(
                        child: TextButton(
                          onPressed:
                              DetailPageController.of().launchBookPreview,
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
