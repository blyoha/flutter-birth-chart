import 'dart:math';

import 'package:birth_chart/src/extensions/double_extension.dart';

/// Helper class to calculate chart positions and angles
///
/// This class provides methods to calculate chart positions and angles
/// in a polar coordinate system.
class ChartUtils {
  /// Full circle in radians 
  static double get fullCircle => 2 * pi;

  /// Calculates a point in a polar coordinate system
  ///
  /// This method calculates a point in a polar coordinate system.
  /// The point is determined by the given [distanceX] and [angleDeg].
  /// The optional [distanceY] can be used to specify a different distance
  /// for the y-axis. If [distanceY] is not specified, [distanceX] is used.
  ///
  /// The method returns a named record with [x] and [y] attributes.
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
