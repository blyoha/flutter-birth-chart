/// Data class representing a chart zodiac sign
///
/// Contains a [sign] and an optional [name]
///
/// Used to represent signs in a birth chart
///
/// For example, in a chart of Aries, the first sign is '♈' and its name is 'Aries'
class ChartSign {
  ChartSign({
    required this.sign,
    this.name,
  });

  final String sign;
  final String? name;
}

/// Data class representing a chart house
///
/// Contains a [position] and an optional [name]
///
/// Used to represent houses in a birth chart
class ChartHouse {
  ChartHouse({
    required this.position,
    this.name,
  });

  final double position;
  final String? name;
}

/// Data class representing a chart planet
///
/// Contains a [position] and an optional [name]
///
/// Used to represent planets in a birth chart
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

/// Data class representing a chart aspect
///
/// Contains a [planet1], [planet2], and a [type]
///
/// [ChartPainter] will draw a line between the two planets.
/// The color of the line depends on the [type]
///
/// Used to represent aspects in a birth chart
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

/// Data class representing a chart axis
///
/// Contains a [type] and a [position]
///
/// Used to represent axes in a birth chart
class ChartAxis {
  ChartAxis({
    required this.type,
    required this.position,
  });

  final ChartAxisType type;
  final double position;
}

/// Enum representing the type of a chart axis
///
/// Can be 'asc' (ascendant), 'dcs' (descendant), 'mc' (midheaven), or 'ic' (innermost house cusp)
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

/// Enum representing the type of an aspect
///
/// Can be 'green' or 'red'
enum ChartAspectType { green, red }
