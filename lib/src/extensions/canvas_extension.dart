import 'dart:ui';

import 'package:flutter/material.dart';

extension CanvasExt on Canvas {
  void drawTextInRect(
    Rect rect,
    Alignment alignment,
    TextPainter painter,
  ) {
    final offsetRect = alignment.inscribe(painter.size, rect);
    painter.paint(this, offsetRect.topLeft);
  }

  void drawDashedLine(
    Paint paint,
    Offset point1,
    Offset point2, {
    double dashSize = 2,
  }) {
    final pattern = [dashSize, dashSize];
    final distance = (point2 - point1).distance;
    final normalizedPattern = pattern.map((width) => width / distance).toList();
    final points = <Offset>[];

    double t = 0;
    int i = 0;

    while (t < 1) {
      points.add(Offset.lerp(point1, point2, t)!);
      t += normalizedPattern[i++]; // dashWidth
      points.add(Offset.lerp(point1, point2, t.clamp(0, 1))!);
      t += normalizedPattern[i++]; // dashSpace
      i %= normalizedPattern.length;
    }

    drawPoints(PointMode.lines, points, paint);
  }
}
