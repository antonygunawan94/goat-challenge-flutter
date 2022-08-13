import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:goat_challenge/src/detail/detail_page.dart';
import 'package:goat_challenge/src/main/main_page.dart';
import 'package:goat_challenge/src/route/goat_challenge_routes.dart';
import 'package:goat_challenge/src/similar/similar_page.dart';

class GoatChallengeApp extends StatelessWidget {
  const GoatChallengeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: GoatChallengeRoutes.main,
        getPages: [
          GetPage(
            name: GoatChallengeRoutes.main,
            page: () => const MainPage(),
          ),
          GetPage(
            name: GoatChallengeRoutes.similar(),
            page: () => const SimilarPage(),
          ),
          GetPage(
            name: GoatChallengeRoutes.detail(),
            page: () => const DetailPage(),
          ),
        ],
      ),
    );
  }
}
