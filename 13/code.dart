import 'dart:collection';
import 'dart:io';
import 'dart:convert';
import 'dart:math';

/* Implement part 1 */
int part1(int depart, List<int> ids) {
  int curr = depart;
  while (true) {
    for (final id in ids)
      if (id != -1 && curr % id == 0) return (id * (curr - depart));
    curr++;
  }
}

/* Implement the chinese remainder theorem */
BigInt chineseRemainder(List<BigInt> a_arr, List<BigInt> n_arr) {
  int sz = a_arr.length;

  /* Compute N = n1 * n2 * ... * n_k*/
  BigInt N = BigInt.one;
  for (final n in n_arr) {
    N *= n;
  }

  BigInt solution = BigInt.zero;
  for (int i = 0; i < sz; i++) {
    BigInt p = BigInt.from(N / n_arr[i]);
    solution += a_arr[i] * p * p.modInverse(n_arr[i]);
  }

  return solution % N;
}

/* Implement part 2 */
String part2(List<int> ids) {
  List<BigInt> a_arr = List(), n_arr = List();
  for (int i = 0; i < ids.length; i++) {
    if (ids[i] != -1) {
      a_arr.add(BigInt.from(-1 * i));
      n_arr.add(BigInt.from(ids[i]));
    }
  }
  return chineseRemainder(a_arr, n_arr).toString();
}

/** Application entry point */
void main() {
  const path = "input.txt";
  final file = File(path);
  final lines = file.readAsLinesSync();
  final depart = int.parse(lines[0]);
  final idstr = lines[1].split(",");
  List<int> ids = List();
  for (final id in idstr) {
    if (id == 'x')
      ids.add(-1);
    else
      ids.add(int.parse(id));
  }

  print('Part1: ${part1(depart, ids)}');
  print('Part2: ${part2(ids)}');
}
