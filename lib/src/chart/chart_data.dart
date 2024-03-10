class ChartSign {
  ChartSign({
    required this.sign,
    this.name,
  });

  final String sign;
  final String? name;
}

class ChartHouse {
  ChartHouse({
    required this.position,
    this.name,
  });

  final double position;
  final String? name;
}

class ChartPlanet {
  ChartPlanet({
    required this.position,
    required this.sign,
    this.name,
  });

  final double position;
  final String sign;
  final String? name;
}

class ChartAspect {
  ChartAspect({
    required this.planet1,
    required this.planet2,
    required this.type,
  });

  final ChartPlanet planet1;
  final ChartPlanet planet2;
  final ChartAspectType type;
}

class ChartAxis {
  ChartAxis({
    required this.type,
    required this.position,
  });

  final ChartAxisType type;
  final double position;
}

enum ChartAxisType {
  asc,
  dcs,
  mc,
  ic;

  @override
  String toString() {
    switch (this) {
      case asc:
        return 'Asc';
      case dcs:
        return 'Dcs';
      case mc:
        return 'Mc';
      case ic:
        return 'Ic';
    }
  }
}

enum ChartAspectType { green, red }
