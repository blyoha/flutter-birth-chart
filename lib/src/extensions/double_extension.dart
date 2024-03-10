import 'dart:math';

extension DoubleExt on num {
  double toRadian() => this * pi / 180;
  double toDegree() => this * 180 / pi;
}
