import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailSectionWithList extends StatelessWidget {
  final String title;
  final List<String> items;
  final Function(String)? onItemTap;

  const DetailSectionWithList(
      {Key? key, required this.title, required this.items, this.onItemTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final onItemTap = this.onItemTap;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
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
            itemCount: items.length,
            itemBuilder: (context, index) =>
                InkWell(
                  onTap: onItemTap != null
                      ? () => onItemTap(items[index])
                      : null,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 2.25.h),
                    child: Text(
                      "· ${items[index]}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
          ),
        )
      ],
    );
  }
}
