import 'package:flutter/material.dart';

class TranslationPositioned extends StatelessWidget {
  final Widget child;

  final double? startTop;
  final double? endTop;
  final double? fixTop;

  final double? startLeft;
  final double? endLeft;
  final double? fixLeft;

  final double? startRight;
  final double? endRight;
  final double? fixRight;

  final double? startBottom;
  final double? endBottom;
  final double? fixBottom;

  final Curve curve;

  final double percent;

  TranslationPositioned({
    required this.percent,
    required this.child,
    this.startTop,
    this.endTop,
    this.fixTop,
    this.startLeft,
    this.endLeft,
    this.fixLeft,
    this.startRight,
    this.endRight,
    this.fixRight,
    this.startBottom,
    this.endBottom,
    this.fixBottom,
    this.curve = Curves.easeIn,
  });

  @override
  Widget build(BuildContext context) {
    final startTop = this.startTop;
    final endTop = this.endTop;

    final startBottom = this.startBottom;
    final endBottom = this.endBottom;

    final startLeft = this.startLeft;
    final endLeft = this.endLeft;

    final startRight = this.startRight;
    final endRight = this.endRight;

    final top = (fixTop != null)
        ? fixTop
        : (startTop != null && endTop != null)
            ? _calculateTranslation(startTop, endTop, percent)
            : null;
    final left = (fixLeft != null)
        ? fixLeft
        : (startLeft != null && endLeft != null)
            ? _calculateTranslation(startLeft, endLeft, percent)
            : null;
    final right = (fixRight != null)
        ? fixRight
        : (startRight != null && endRight != null)
            ? _calculateTranslation(startRight, endRight, percent)
            : null;
    final bottom = (fixBottom != null)
        ? fixBottom
        : (startBottom != null && endBottom != null)
            ? _calculateTranslation(startBottom, endBottom, percent)
            : null;

    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: child,
    );
  }

  double _calculateTranslation(double max, double min, double percent) {
    if (percent > 1) percent = 1;
    if (percent < 0) percent = 0;
    final curvePercent = curve.transform(percent);
    return curvePercent * (max - min) + min;
  }
}
