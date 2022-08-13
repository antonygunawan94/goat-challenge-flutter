import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goat_challenge/src/common/widgets/curve_opacity.dart';
import 'package:goat_challenge/src/common/widgets/translation_positioned.dart';
import 'package:goat_challenge/src/main/widgets/main_search_bar.dart';

class MainAppBar extends StatelessWidget {
  final _appBarHeight = 160.h;

  MainAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      pinned: true,
      expandedHeight: _appBarHeight,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final percent = ((constraints.maxHeight - kToolbarHeight) /
              (_appBarHeight - kToolbarHeight));

          return Stack(
            children: [
              TranslationPositioned(
                percent: percent,
                startTop: 20.h,
                endTop: -50.h,
                startLeft: 15.w,
                endLeft: -50.w,
                child: CurveOpacity(
                  percent: percent,
                  child: Text(
                    "Explore",
                    style: TextStyle(
                      fontSize: 30.sp,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              TranslationPositioned(
                percent: percent,
                startTop: 50.h,
                endTop: -50.h,
                startRight: 15.w,
                endRight: -50.w,
                child: CurveOpacity(
                  percent: percent,
                  child: Text(
                    "Our book collections",
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              TranslationPositioned(
                percent: percent,
                startTop: 90.h,
                endTop: 10.h,
                fixLeft: 15.w,
                fixRight: 15.w,
                child: MainSearchBar(
                  percent: percent,
                  startHeight: 50.h,
                  endHeight: 35.h,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
