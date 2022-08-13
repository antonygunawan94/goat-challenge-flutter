import 'package:flutter/material.dart';
import 'package:goat_challenge/src/main/main_page_controller.dart';

class MainSearchBar extends StatelessWidget {
  final double percent;

  final double? startWidth;
  final double? endWidth;
  final double? fixWidth;

  final double? startHeight;
  final double? endHeight;
  final double? fixHeight;

  final Curve curve;

  MainSearchBar({
    required this.percent,
    this.startWidth,
    this.endWidth,
    this.fixWidth,
    this.startHeight,
    this.endHeight,
    this.fixHeight,
    this.curve = Curves.easeIn,
  });

  @override
  Widget build(BuildContext context) {
    final startWidth = this.startWidth;
    final endWidth = this.endWidth;

    final startHeight = this.startHeight;
    final endHeight = this.endHeight;

    final width = (fixWidth != null)
        ? fixWidth
        : (endWidth != null && startWidth != null)
            ? _calculateScale(endWidth, startWidth, percent)
            : null;
    final height = (fixHeight != null)
        ? fixHeight
        : (endHeight != null && startHeight != null)
            ? _calculateScale(endHeight, startHeight, percent)
            : null;

    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        onChanged: (value) => MainPageController.of().searchQuery = value,
        decoration: InputDecoration(
          focusColor: Colors.grey,
          prefixIcon: const Icon(Icons.search),
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
          enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
          disabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
          contentPadding: EdgeInsets.zero,
          isDense: true,
          filled: true,
          fillColor: Colors.grey.shade100,
          hintText: "Find your favorite books",
        ),
      ),
    );
  }

  double _calculateScale(double min, double max, double percent) {
    final curvePercent = curve.transform(percent);
    return curvePercent * (max - min) + min;
  }
}
