import 'package:flutter/material.dart';

class CurveOpacity extends StatelessWidget {
  final double percent;
  final Curve curve;
  final Widget child;

  const CurveOpacity({
    required this.percent,
    required this.child,
    this.curve = Curves.easeIn,
  });

  @override
  Widget build(BuildContext context) {
    final opacity = curve.transform(percent);
    return Opacity(
      opacity: opacity,
      child: child,
    );
  }
}
