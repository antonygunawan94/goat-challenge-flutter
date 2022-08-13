import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DetailAppBar extends StatelessWidget {
  const DetailAppBar({Key? key}) : super(key: key);

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
        Text(
          "Find out about",
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.black87,
          ),
        ),
        Expanded(child: Container()),
      ],
    );
  }
}
