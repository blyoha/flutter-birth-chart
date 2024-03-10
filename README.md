# Birth Chart Flutter widget.
A simple customizable birth chart with custom data, colors and other stuff.

![Package version](https://img.shields.io/badge/version-1.0.0-blue)

---

## Example
See the [example](./example) for more details.
<div>
    <img src="screenshots/example.gif" width="320" alt="Example GIF" >
</div>

```dart
BirthChart(
  houses: List.generate(12, (_) => ChartHouse(position: 20)),
  planets: [
    ChartPlanet(position: 111, sign: '♈'),
    ChartPlanet(position: 71, sign: '♓'),
  ],
  aspects: [
    ChartAspect(
      planet1: ChartPlanet(position: 111, sign: '♈'),
      planet2: ChartPlanet(position: 71, sign: '♓'),
      type: ChartAspectType.red,
    ),
  ],
);
```

## Installation
```sh
$ flutter pub get birth_chart
```
