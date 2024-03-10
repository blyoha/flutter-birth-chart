import 'package:flutter/material.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({
    required this.title,
    required this.minValue,
    required this.maxValue,
    required this.onValueChanged,
    this.initialValue,
    super.key,
  });

  final String title;
  final double? initialValue;
  final double minValue;
  final double maxValue;
  final ValueChanged<double> onValueChanged;

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  late double selectedValue;

  @override
  void initState() {
    selectedValue = widget.initialValue ?? widget.minValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        Slider.adaptive(
          value: selectedValue,
          min: widget.minValue,
          max: widget.maxValue,
          onChanged: (value) {
            widget.onValueChanged(selectedValue);
            setState(() => selectedValue = value);
          },
        ),
      ],
    );
  }
}
