import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goat_challenge/src/main/main_page_controller.dart';

class SimilarBook extends StatelessWidget {
  final int id;
  final String title;
  final String imageUrl;
  final String author;
  final List<String> languages;

  const SimilarBook({
    Key? key,
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.author,
    required this.languages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5.0,
              spreadRadius: 2.0,
            )
          ]),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () => MainPageController.of().goToBookDetail(id),
          child: Row(
            children: [
              CachedNetworkImage(
                width: 100.w,
                height: double.maxFinite,
                imageUrl: imageUrl,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                fit: BoxFit.cover,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20.h, bottom: 5.h),
                        child: Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 17.sp,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 20.h),
                        child: Text(
                          author,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
                      Container(
                        height: 16.h,
                        margin: EdgeInsets.only(bottom: 10.h),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              languages.length > 3 ? 3 : languages.length,
                          itemBuilder: (context, index) {
                            var margin = EdgeInsets.symmetric(horizontal: 5.w);

                            if (index == 0) {
                              margin = EdgeInsets.only(left: 0.w, right: 5.w);
                            }

                            final maxLength =
                                (languages.length > 3 ? 3 : languages.length) -
                                    1;

                            if (index == maxLength && maxLength != 0) {
                              margin = EdgeInsets.only(left: 5.w, right: 0.w);
                            }

                            return Container(
                              margin: margin,
                              padding: EdgeInsets.symmetric(
                                  vertical: 1.h, horizontal: 5.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.grey[350],
                              ),
                              child: Text(
                                languages[index],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
