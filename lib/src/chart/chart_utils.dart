import 'dart:math';

import 'package:birth_chart/src/extensions/double_extension.dart';

class ChartUtils {
  static double get fullCircle => 2 * pi;

  static ({double x, double y}) calculatePosition({
    required double distanceX,
    required double angleDeg,
    double? distanceY,
  }) {
    distanceY ??= distanceX;

    double x = distanceX * cos(angleDeg.toRadian());
    double y = distanceY * sin(angleDeg.toRadian());

    return (x: x, y: y);
  }
}
