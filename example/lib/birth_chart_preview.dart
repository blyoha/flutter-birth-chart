import 'package:birth_chart/birth_chart.dart';
import 'package:flutter/material.dart';

import 'helpers/color_selector_widget.dart';
import 'helpers/slider_widget.dart';

class BirthChartPreview extends StatefulWidget {
  const BirthChartPreview({super.key});

  @override
  State<BirthChartPreview> createState() => _BirthChartPreviewState();
}

class _BirthChartPreviewState extends State<BirthChartPreview> {
  final _colors = [
    Colors.white,
    Colors.blue,
    Colors.greenAccent,
  ];
  final _textColors = [
    Colors.black,
    Colors.white,
    Colors.deepPurpleAccent,
  ];

  late double _selectedSize;
  late double _selectedCenterSize;
  late Color _selectedColor;
  late Color _selectedLinesColor;
  late Color _selectedAxesColor;
  late Color _selectedTextColor;
  late Color _selectedCenterColor;
  late int _selectedSerifsCount;
  late double _selectedSignsRowSize;
  late double _selectedAxesLabelFontSize;
  late double _selectedSignsRotationAngle;
  late double _selectedHousesRotationAngle;

  @override
  void initState() {
    _selectedSize = 200;
    _selectedColor = _colors.first;
    _selectedLinesColor = _textColors.first;
    _selectedCenterSize = 0.5;
    _selectedAxesColor = _textColors.first;
    _selectedTextColor = _textColors.first;
    _selectedCenterColor = _colors.first;
    _selectedSerifsCount = 5;
    _selectedSignsRowSize = 50;
    _selectedAxesLabelFontSize = 10;
    _selectedSignsRotationAngle = 0;
    _selectedHousesRotationAngle = 0;

    super.initState();
  }

  Widget _buildChart() {
    final houses = List.generate(12, (_) => ChartHouse(position: 20));
    final planets = <ChartPlanet>[
      ChartPlanet(position: 111, sign: '♈'),
      ChartPlanet(position: 71, sign: '♓'),
      ChartPlanet(position: 207, sign: '♍'),
      ChartPlanet(position: 189, sign: '♎ '),
    ];
    final aspects = <ChartAspect>[
      ChartAspect(
        planet1: planets[0],
        planet2: planets[1],
        type: ChartAspectType.red,
      ),
      ChartAspect(
        planet1: planets[0],
        planet2: planets[2],
        type: ChartAspectType.green,
      ),
      ChartAspect(
        planet1: planets[3],
        planet2: planets[1],
        type: ChartAspectType.red,
      ),
    ];

    return BirthChart(
      houses: houses,
      planets: planets,
      aspects: aspects,
      signsRotationAngle: _selectedSignsRotationAngle,
      housesRotationAngle: _selectedHousesRotationAngle,
      radius: _selectedSize,
      centerSize: _selectedCenterSize,
      centerColor: _selectedCenterColor,
      backgroundColor: _selectedColor,
      linesColor: _selectedLinesColor,
      axesLabelsColor: _selectedAxesColor,
      textColor: _selectedTextColor,
      signsInnerSerifsCount: _selectedSerifsCount,
      signsRowSize: _selectedSignsRowSize,
      axesLabelFontSize: _selectedAxesLabelFontSize,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Birth Chart Example')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildChart(),
                const Divider(height: 24),
                SliderWidget(
                  title: 'Chart size',
                  minValue: 200,
                  maxValue: MediaQuery.sizeOf(context).width - 100,
                  onValueChanged: (value) =>
                      setState(() => _selectedSize = value),
                ),
                const SizedBox(height: 4),
                SliderWidget(
                  title: 'Signs rotation angle',
                  minValue: 0,
                  maxValue: 360,
                  onValueChanged: (value) =>
                      setState(() => _selectedSignsRotationAngle = value),
                ),
                const SizedBox(height: 4),
                SliderWidget(
                  title: 'Houses rotation angle',
                  minValue: 0,
                  maxValue: 360,
                  onValueChanged: (value) =>
                      setState(() => _selectedHousesRotationAngle = value),
                ),
                const SizedBox(height: 4),
                SliderWidget(
                  title: 'Center hole size',
                  minValue: 0.2,
                  maxValue: 0.9,
                  onValueChanged: (value) =>
                      setState(() => _selectedCenterSize = value),
                ),
                const SizedBox(height: 4),
                SliderWidget(
                  title: 'Amount of minor serifs',
                  minValue: 1,
                  maxValue: 10,
                  onValueChanged: (value) =>
                      setState(() => _selectedSerifsCount = value.toInt()),
                ),
                const SizedBox(height: 4),
                SliderWidget(
                  title: 'Signs row size',
                  minValue: 10,
                  maxValue: 100,
                  onValueChanged: (value) =>
                      setState(() => _selectedSignsRowSize = value),
                ),
                const SizedBox(height: 4),
                SliderWidget(
                  title: 'Axes font size',
                  minValue: 10,
                  maxValue: 20,
                  onValueChanged: (value) =>
                      setState(() => _selectedAxesLabelFontSize = value),
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 20,
                  runSpacing: 10,
                  children: [
                    ColorSelectorWidget(
                      title: 'Chart color',
                      values: _colors,
                      onValueChanged: (value) =>
                          setState(() => _selectedColor = value),
                    ),
                    ColorSelectorWidget(
                      title: 'Text color',
                      values: _textColors,
                      onValueChanged: (value) =>
                          setState(() => _selectedTextColor = value),
                    ),
                    ColorSelectorWidget(
                      title: 'Axes text color',
                      values: _textColors,
                      onValueChanged: (value) =>
                          setState(() => _selectedAxesColor = value),
                    ),
                    ColorSelectorWidget(
                      title: 'Lines color',
                      values: _textColors,
                      onValueChanged: (value) =>
                          setState(() => _selectedLinesColor = value),
                    ),
                    ColorSelectorWidget(
                      title: 'Center color',
                      values: _colors,
                      onValueChanged: (value) =>
                          setState(() => _selectedCenterColor = value),
                    ),
                  ],
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
