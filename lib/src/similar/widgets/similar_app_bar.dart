import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:goat_challenge/src/similar/similar_page_controller.dart';

class SimilarAppBar extends StatelessWidget {
  final String tag;

  const SimilarAppBar({Key? key, required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: IconButton(
            onPressed: Get.back,
            icon: const Icon(Icons.arrow_back),
            visualDensity: VisualDensity.compact,
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            "Similar books by ${SimilarPageController.of(tag).findBy}",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 17.sp,
              color: Colors.black87,
            ),
          ),
        ),
        Expanded(child: Container()),
      ],
    );
  }
}
