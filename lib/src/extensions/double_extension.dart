import 'dart:math';

/// Extension methods for [double]
extension DoubleExt on num {
  /// Converts degrees to radians
  double toRadian() => this * pi / 180;

  /// Converts radians to degrees
  double toDegree() => this * 180 / pi;
}
