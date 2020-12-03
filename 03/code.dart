import 'dart:convert';
import 'dart:io';

/* Implement the part 1 of the problem */
void part1(List<String> input) {
  print(traverse(input, 3, 1));
}

/* Implement part 2 of the problem */
void part2(List<String> input) {
  int val = 1;
  val *= traverse(input, 1, 1);
  val *= traverse(input, 3, 1);
  val *= traverse(input, 5, 1);
  val *= traverse(input, 7, 1);
  val *= traverse(input, 1, 2);
  print(val);
}

/* Implement the traversal */
int traverse(List<String> input, int dx, int dy) {
  int x = 0, y = 0;
  int NumTrees = 0;
  while(y < input.length) {
    if (input[y][x] == '#') NumTrees++;
    x += dx;
    x = x % input[0].length;
    y += dy;
  }
  return NumTrees;
}

/* Application entry point */
void main() {
  const path = "input.txt";
  List<String> input = List();
  new File(path)
      .openRead()
      .map(utf8.decode)
      .transform(new LineSplitter())
      .forEach((element) => input.add(element))
      .then((value) => part1(input))
      .then((value) => part2(input));
}