import 'dart:collection';
import 'dart:io';
import 'dart:convert';
import 'dart:math';

class Ferry {
  int x = 0;
  int y = 0;
  int dir = 0;

  void step(String act, int arg) {
    if (act == "N")
      y += arg;
    else if (act == "S")
      y -= arg;
    else if (act == "E")
      x += arg;
    else if (act == "W")
      x -= arg;
    else if (act == "L") {
      dir += arg;
      while (dir < 0) dir += 360;
      while (dir >= 360) dir -= 360;
    } else if (act == "R") {
      dir -= arg;
      while (dir < 0) dir += 360;
      while (dir >= 360) dir -= 360;
    } else if (act == "F") {
      if (dir == 0)
        x += arg;
      else if (dir == 90)
        y += arg;
      else if (dir == 180)
        x -= arg;
      else if (dir == 270)
        y -= arg;
      else {
        print(dir);
        throw new Error();
      }
    }
  }
}

class WaypointFerry {
  double x = 0;
  double y = 0;
  double wx = 10;
  double wy = 1;

  void step(String act, int arg) {
    if (act == "N")
      wy += arg;
    else if (act == "S")
      wy -= arg;
    else if (act == "E")
      wx += arg;
    else if (act == "W")
      wx -= arg;
    else if (act == "L") {
      double dx = wx * cos(arg / 180 * pi) + wy * cos((arg + 90) / 180 * pi);
      double dy = wx * sin(arg / 180 * pi) + wy * sin((arg + 90) / 180 * pi);
      wx = dx;
      wy = dy;
    } else if (act == "R") {
      double dx = wx * cos((-arg) / 180 * pi) + wy * cos((90 - arg) / 180 * pi);
      double dy = wx * sin((-arg) / 180 * pi) + wy * sin((90 - arg) / 180 * pi);
      wx = dx;
      wy = dy;
    } else if (act == "F") {
      x += arg * wx;
      y += arg * wy;
    }
  }
}

/* Implement part 1 */
int part1(List<String> instructions) {
  Ferry ferry = Ferry();
  for (final inst in instructions) {
    String act = inst[0];
    int arg = int.parse(inst.substring(1));
    ferry.step(act, arg);
  }
  return (ferry.x.abs() + ferry.y.abs());
}

/* Implement part 2 */
int part2(List<String> instructions) {
  WaypointFerry ferry = WaypointFerry();
  for (final inst in instructions) {
    String act = inst[0];
    int arg = int.parse(inst.substring(1));
    ferry.step(act, arg);
  }
  return (ferry.x.abs() + ferry.y.abs()).round();
}

/** Application entry point */
void main() {
  const path = "input.txt";
  final file = File(path);
  final lines = file.readAsLinesSync();

  print('Part1: ${part1(lines)}');
  print('Part2: ${part2(lines)}');
}
