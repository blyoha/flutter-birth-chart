import 'package:birth_chart/birth_chart.dart';
import 'package:birth_chart/src/chart/chart_painter.dart';
import 'package:flutter/material.dart';


/// A widget that renders a birth chart
///
/// It takes lists of [ChartHouse], [ChartSign], [ChartPlanet], and [ChartAspect] as arguments,
/// and renders a birth chart based on these data.
///
/// You can customize the chart's appearance by providing [radius], [centerSize],
/// [signsRowSize], [signsRotationAngle], and [housesRotationAngle] parameters.
class BirthChart extends StatelessWidget {
  const BirthChart({
    required this.houses,
    required this.aspects,
    required this.planets,
    this.radius,
    this.centerSize = 0.5,
    this.signsRowSize = 50,
    this.signsRotationAngle = 0,
    this.housesRotationAngle = 0,
    this.signsInnerSerifsCount = 5,
    this.showAxes = true,
    this.linesColor = Colors.black,
    this.textColor = Colors.black,
    this.axesLabelsColor = Colors.white,
    this.centerColor = Colors.white,
    this.backgroundColor = const Color(0xFFF8ECCF),
    this.axesLabelFontSize = 11,
    super.key,
  });

  final List<ChartHouse> houses;
  final List<ChartPlanet> planets;
  final List<ChartAspect> aspects;

  final double? radius;
  final double centerSize;
  final double signsRowSize;
  final double signsRotationAngle;
  final double housesRotationAngle;
  final int signsInnerSerifsCount;

  final bool showAxes;

  final Color linesColor;
  final Color textColor;
  final Color axesLabelsColor;
  final Color centerColor;
  final Color backgroundColor;

  final double axesLabelFontSize;

  @override
  Widget build(BuildContext context) {
    final signs = [
      ChartSign(sign: '♈', name: 'Aries'),
      ChartSign(sign: '♉', name: 'Taurus'),
      ChartSign(sign: '♊', name: 'Gemini'),
      ChartSign(sign: '♋', name: 'Cancer'),
      ChartSign(sign: '♌', name: 'Leo'),
      ChartSign(sign: '♍', name: 'Virgo'),
      ChartSign(sign: '♎', name: 'Libra'),
      ChartSign(sign: '♏', name: 'Scorpio'),
      ChartSign(sign: '♐', name: 'Sagittarius'),
      ChartSign(sign: '♑', name: 'Capricorn'),
      ChartSign(sign: '♒', name: 'Aquarius'),
      ChartSign(sign: '♓', name: 'Pisces'),
    ];

    final axes = [
      ChartAxis(type: ChartAxisType.asc, position: 0),
      ChartAxis(type: ChartAxisType.dcs, position: 90),
      ChartAxis(type: ChartAxisType.mc, position: 180),
      ChartAxis(type: ChartAxisType.ic, position: 270),
    ];

    return Container(
      alignment: Alignment.center,
      child: LayoutBuilder(
        builder: (_, constraints) {
          return SizedBox(
            height: radius != null
                ? constraints.maxWidth < radius!
                    ? constraints.maxWidth
                    : radius
                : null,
            child: CustomPaint(
              painter: ChartPainter(
                signs: signs,
                houses: houses,
                planets: planets,
                aspects: aspects,
                axes: axes,
                signsRotationAngle: signsRotationAngle,
                housesRotationAngle: housesRotationAngle,
                linesColor: linesColor,
                textColor: textColor,
                axesLabelsColor: axesLabelsColor,
                centerColor: centerColor,
                backgroundColor: backgroundColor,
                centerSize: centerSize,
                signsRowSize: signsRowSize,
                axesLabelFontSize: axesLabelFontSize,
                signsInnerSerifsCount: signsInnerSerifsCount,
              ),
              child: const AspectRatio(aspectRatio: 1),
            ),
          );
        },
      ),
    );
  }
}
