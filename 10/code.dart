import 'dart:collection';
import 'dart:io';
import 'dart:convert';
import 'dart:math';

/* Implement part 1 */
int part1(List<int> adapters) {
  /* Sort the adapters */
  adapters.sort();

  /* Insert the default adapter */
  adapters.add(adapters[adapters.length - 1] + 3);

  List<int> diff = List<int>.filled(4, 0);

  int curr = 0;
  for (int i = 0; i < adapters.length; i++) {
    if (adapters[i] > curr + 3) throw new Error();
    diff[adapters[i] - curr]++;
    curr = adapters[i];
  }

  return diff[1] * diff[3];
}

/* Implement part 2 */
int part2(List<int> adapters) {
  /* Setup the dp map */
  Map<int, int> dp = new HashMap();

  /* Insert the first element of 0 */
  adapters.insert(0, 0);

  /* There is 1 solution when starting from the final adapter */
  dp.putIfAbsent(adapters.length - 1, () => 1);

  /* Loop from the end */
  for (int i = adapters.length - 2; i >= 0; i--) {
    int j = i + 1;
    dp.putIfAbsent(i, () => 0);
    while ((j < adapters.length) && (adapters[j] <= adapters[i] + 3)) {
      dp[i] += dp[j];
      j++;
    }
  }

  return dp[0];
}

/** Application entry point */
void main() {
  const path = "input.txt";
  List<int> adapters = new List();
  new File(path)
      .openRead()
      .map(utf8.decode)
      .transform(new LineSplitter())
      .forEach((element) => adapters.add(int.parse(element)))
      .then((value) => print('Part1: ${part1(adapters)}'))
      .then((value) => print('Part2: ${part2(adapters)}'));
}
