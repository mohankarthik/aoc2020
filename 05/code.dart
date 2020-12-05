import 'dart:convert';
import 'dart:io';
import 'dart:math';

Map<String, int> tests = {
  "FBFBBFFRLR": 357,
  "BFFFBBFRRR": 567,
  "FFFBBBFRRR": 119,
  "BBFFBBFRLL": 820
};

int decode(String str) {
  int min = 0, max = 128, mid = (min + max) ~/ 2;
  int idx = 0;

  /* Get the row */
  for (; idx < 7; idx++) {
    if (str[idx] == "F")
      max = mid;
    else
      min = mid;
    mid = (min + max) ~/ 2;
  }
  int row = mid;

  /* Get the column */
  min = 0;
  max = 8;
  mid = (min + max ~/ 2);
  for (; idx < 10; idx++) {
    if (str[idx] == "L")
      max = mid;
    else
      min = mid;
    mid = (min + max) ~/ 2;
  }
  int col = mid;

  /* Find the unique value */
  return (row * 8) + col;
}

void part1(List<int> passes) {
  /* Just print out the max */
  print('Part1: ${passes.reduce(max)}');
}

void part2(List<int> passes) {
  /* Sort the array */
  passes.sort();

  for (int i = 1; i < passes.length - 1; i++) {
    if (passes[i - 1] != passes[i] - 1) {
      print('Part2: ${passes[i] - 1}');
      exit(0);
    }
  }
}

void main() {
  const path = "input.txt";
  List<int> passes = new List();
  new File(path)
      .openRead()
      .map(utf8.decode)
      .transform(new LineSplitter())
      .forEach((element) => passes.add(decode(element)))
      .then((value) => part1(passes))
      .then((value) => part2(passes));
}
