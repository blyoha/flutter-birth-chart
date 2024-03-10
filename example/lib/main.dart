import 'package:example/birth_chart_preview.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Birth Chart Example',
      debugShowCheckedModeBanner: false,
      home: BirthChartPreview(),
    );
  }
}
