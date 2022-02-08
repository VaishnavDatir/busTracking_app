import 'package:flutter/material.dart';

import '../../theme/dimensions.dart';

class CustomMarker extends ShapeBorder {
  final bool usePadding;

  CustomMarker({this.usePadding = true});

  @override
  EdgeInsetsGeometry get dimensions =>
      EdgeInsets.only(bottom: usePadding ? 20 : 0);

  /* @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => null; */

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    rect = Rect.fromPoints(rect.topLeft, rect.bottomRight - Offset(0, 20));
    return Path()
      ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(kRadius / 4)))
      ..moveTo(rect.bottomCenter.dx - 10, rect.bottomCenter.dy)
      ..relativeLineTo(7, 15)
      ..relativeLineTo(14, -15)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    // TODO: implement getInnerPath
    // throw UnimplementedError();
    return Path();
  }
}
