import 'package:flutter/material.dart';

class ColorSelectorWidget extends StatefulWidget {
  const ColorSelectorWidget({
    required this.title,
    required this.values,
    required this.onValueChanged,
    super.key,
  });

  final List<Color> values;
  final String title;
  final ValueChanged<Color> onValueChanged;

  @override
  State<ColorSelectorWidget> createState() => _ColorSelectorWidgetState();
}

class _ColorSelectorWidgetState extends State<ColorSelectorWidget> {
  late Color selectedValue;

  @override
  void initState() {
    selectedValue = widget.values.first;
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
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            widget.values.length,
            (index) => GestureDetector(
              onTap: () => setState(() {
                selectedValue = widget.values[index];
                widget.onValueChanged(selectedValue);
              }),
              child: Container(
                height: 60,
                width: 60,
                color: widget.values[index],
                child: index == widget.values.indexOf(selectedValue)
                    ? const Icon(
                        Icons.check,
                        color: Colors.red,
                      )
                    : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
