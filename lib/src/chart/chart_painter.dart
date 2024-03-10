import 'package:birth_chart/birth_chart.dart';
import 'package:birth_chart/src/chart/chart_utils.dart';
import 'package:birth_chart/src/extensions/canvas_extension.dart';
import 'package:birth_chart/src/extensions/double_extension.dart';
import 'package:flutter/material.dart';

class ChartPainter extends CustomPainter {
  ChartPainter({
    required List<ChartSign> signs,
    required List<ChartHouse> houses,
    required List<ChartPlanet> planets,
    required List<ChartAxis> axes,
    required int signsInnerSerifsCount,
    required double signsRotationAngle,
    required double housesRotationAngle,
    required Color linesColor,
    required Color textColor,
    required Color axesLabelsColor,
    required Color centerColor,
    required Color backgroundColor,
    required double centerSize,
    required double signsRowSize,
    required double axesLabelFontSize,
    List<ChartAspect>? aspects,
  })  : _signs = signs,
        _houses = houses,
        _aspects = aspects,
        _planets = planets,
        _axes = axes,
        _signsRotationAngle = signsRotationAngle,
        _housesRotationAngle = housesRotationAngle,
        _linesColor = linesColor,
        _textColor = textColor,
        _axesLabelsColor = axesLabelsColor,
        _centerColor = centerColor,
        _backgroundColor = backgroundColor,
        _centerSize = centerSize,
        _signsRowSize = signsRowSize,
        _axesLabelFontSize = axesLabelFontSize,
        _signsInnerSerifsCount = signsInnerSerifsCount,
        assert(
          centerSize >= 0 && centerSize <= 1,
          'centerSize should be between 0 and 1',
        ),
        assert(
          signsRowSize > 0,
          'signsRowSize should be greater than 0',
        ),
        assert(
          signsInnerSerifsCount >= 0,
          'signsInnerSerifsCount should be greater or equal to 0',
        );

  final List<ChartSign> _signs;
  final List<ChartHouse> _houses;
  final List<ChartAspect>? _aspects;
  final List<ChartPlanet> _planets;
  final List<ChartAxis> _axes;
  final double _signsRotationAngle;
  final double _housesRotationAngle;

  final Color _linesColor;
  final Color _textColor;
  final Color _axesLabelsColor;
  final Color _centerColor;
  final Color _backgroundColor;
  final double _centerSize;
  final double _signsRowSize;
  final double _axesLabelFontSize;
  final int _signsInnerSerifsCount;

  late Offset _chartCenter;
  late double _chartRadius;
  late Canvas _chartCanvas;

  double get _chartDiameter => _chartRadius * 2;

  double get _rotationAngleRad => _housesRotationAngle.toRadian();

  double get _signsRotationAngleRad => _signsRotationAngle.toRadian();

  void _drawText(double x, double y, TextPainter textPainter) {
    Rect rect = Rect.fromCenter(
      center: _chartCenter + Offset(x, y),
      width: textPainter.width,
      height: textPainter.height,
    );

    _chartCanvas.drawTextInRect(rect, Alignment.center, textPainter);
  }

  void _drawBackground() {
    Paint paint = Paint();

    paint.color = _backgroundColor;
    _chartCanvas.drawCircle(_chartCenter, _chartRadius, paint);

    paint.color = _centerColor;
    _chartCanvas.drawCircle(_chartCenter, _chartRadius * _centerSize, paint);

    Paint linePaint = Paint()
      ..color = _linesColor
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    _chartCanvas.drawArc(
      Rect.fromCenter(
        center: _chartCenter,
        width: _chartDiameter * _centerSize,
        height: _chartDiameter * _centerSize,
      ),
      0,
      ChartUtils.fullCircle,
      false,
      linePaint,
    );
  }

  void _drawSigns() {
    Paint paint = Paint()
      ..color = _linesColor
      ..strokeWidth = 1
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke;
    Paint linePaint = Paint()
      ..color = _linesColor
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    _chartCanvas.drawArc(
      Rect.fromCenter(
        center: _chartCenter,
        width: _chartDiameter,
        height: _chartDiameter,
      ),
      0,
      ChartUtils.fullCircle,
      false,
      paint,
    );

    double signsArcSize = _signsRowSize;
    _chartCanvas.drawArc(
      Rect.fromCenter(
        center: _chartCenter,
        width: _chartDiameter - signsArcSize,
        height: _chartDiameter - signsArcSize,
      ),
      0,
      ChartUtils.fullCircle,
      false,
      paint,
    );

    double minorSerifsCount = _signsInnerSerifsCount + 1;
    double totalSerifsCount = _signs.length * minorSerifsCount;
    double minorSerifsSize = signsArcSize / 10;

    double sweepAngle = ChartUtils.fullCircle / totalSerifsCount;

    for (int i = 1; i <= totalSerifsCount; i++) {
      double angle = _signsRotationAngleRad + i * sweepAngle;

      final position1 = ChartUtils.calculatePosition(
        distanceX: _chartRadius,
        angleDeg: angle.toDegree(),
      );

      double serifSize = _chartRadius;

      if (i % minorSerifsCount == 0) {
        serifSize -= signsArcSize / 2;
        linePaint.strokeWidth = 1.2;
      } else {
        serifSize -= minorSerifsSize / 2;
        linePaint.strokeWidth = 1;
      }

      final position2 = ChartUtils.calculatePosition(
        distanceX: serifSize,
        angleDeg: angle.toDegree(),
      );

      Offset p1 = _chartCenter + Offset(position1.x, position1.y);
      Offset p2 = _chartCenter + Offset(position2.x, position2.y);

      _chartCanvas.drawLine(p1, p2, linePaint);
    }

    sweepAngle = ChartUtils.fullCircle / _signs.length;
    for (var ind = 1; ind <= _signs.length; ind++) {
      double angle =
          (sweepAngle / 2) + ind * sweepAngle + _signsRotationAngleRad;

      _drawSignsLabel(_signs[ind - 1].sign, angle, _chartRadius);
    }
  }

  void _drawHouses() {
    Paint linePaint = Paint()
      ..color = _linesColor
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    double sweepAngle = ChartUtils.fullCircle / _houses.length;
    double shift = _signsRowSize / 2 + 2;

    for (var ind = 1; ind <= _houses.length; ind++) {
      double angle = _rotationAngleRad + ind * sweepAngle;

      var position1 = ChartUtils.calculatePosition(
        distanceX: _chartRadius * _centerSize,
        angleDeg: angle.toDegree(),
      );

      var position2 = ChartUtils.calculatePosition(
        distanceX: _chartRadius - shift,
        angleDeg: angle.toDegree(),
      );

      Offset p1 = _chartCenter + Offset(position1.x, position1.y);
      Offset p2 = _chartCenter + Offset(position2.x, position2.y);

      _drawHouseIndex(
        ind.toString(),
        (angle + sweepAngle / 2).toDegree(),
        _chartRadius - shift,
      );

      _chartCanvas.drawDashedLine(linePaint, p1, p2);
    }
  }

  void _drawSignsLabel(String text, double angleRad, double distance) {
    TextStyle textStyle = TextStyle(fontSize: 16, color: _textColor);
    TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr)
      ..text = TextSpan(text: text, style: textStyle)
      ..layout();

    distance -= _signsRowSize / 4;

    final position = ChartUtils.calculatePosition(
      distanceX: distance,
      angleDeg: angleRad.toDegree(),
    );

    _drawText(position.x, position.y, textPainter);
  }

  void _drawHouseIndex(
    String text,
    double angleDeg,
    double distance,
  ) {
    TextStyle textStyle = TextStyle(fontSize: 10, color: _textColor);
    TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr)
      ..text = TextSpan(text: text, style: textStyle)
      ..layout();

    final position = ChartUtils.calculatePosition(
      distanceX: distance - textPainter.width,
      distanceY: distance - textPainter.height / 2,
      angleDeg: angleDeg,
    );

    _drawText(position.x, position.y, textPainter);
  }

  void _drawAspectLines() {
    List<ChartAspect> aspects = _aspects ?? [];

    if (aspects.isEmpty) return;

    Paint paint = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    for (var aspect in aspects) {
      switch (aspect.type) {
        case ChartAspectType.green:
          paint.color = const Color(0xFFC4FFC4);
          break;
        case ChartAspectType.red:
          paint.color = const Color(0xFFFF7C75);
          break;
      }

      double startAngle = aspect.planet2.position.toDegree();
      double sweepAngle = aspect.planet1.position.toDegree();

      final position1 = ChartUtils.calculatePosition(
        distanceX: _chartRadius * _centerSize,
        angleDeg: startAngle,
      );

      final position2 = ChartUtils.calculatePosition(
        distanceX: _chartRadius * _centerSize,
        angleDeg: sweepAngle,
      );

      Offset p1 = _chartCenter + Offset(position1.x, position1.y);
      Offset p2 = _chartCenter + Offset(position2.x, position2.y);

      _chartCanvas.drawLine(p1, p2, paint);
    }
  }

  void _drawPlanets() {
    TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
    TextStyle textStyle = TextStyle(fontSize: 20, color: _textColor);

    for (var planet in _planets) {
      textPainter
        ..text = TextSpan(text: planet.sign, style: textStyle)
        ..layout();

      double shift = _chartRadius * _centerSize / 4;

      final position = ChartUtils.calculatePosition(
        distanceX: _chartRadius * _centerSize + shift,
        angleDeg: planet.position.toDegree(),
      );

      _drawText(position.x, position.y, textPainter);
    }
  }

  void _drawAxes() {
    TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
    TextStyle textStyle = TextStyle(
      fontSize: _axesLabelFontSize,
      color: _axesLabelsColor,
    );

    for (var axis in _axes) {
      textPainter
        ..text = TextSpan(text: axis.type.toString(), style: textStyle)
        ..layout();

      double shift = textPainter.height;

      final position = ChartUtils.calculatePosition(
        distanceX: _chartRadius + shift,
        angleDeg: axis.position,
      );

      _drawText(position.x, position.y, textPainter);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    _chartCenter = Offset(size.width / 2, size.height / 2);

    _chartRadius = size.width / 2 - _axesLabelFontSize * 2.1;
    _chartCanvas = canvas;

    _drawBackground();
    _drawSigns();
    _drawHouses();
    _drawAspectLines();
    _drawPlanets();
    _drawAxes();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
