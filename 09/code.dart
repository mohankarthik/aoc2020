import 'dart:collection';
import 'dart:io';
import 'dart:convert';
import 'dart:math';

/** Implement a stack */
class Stack<T> {
  final _stack = Queue<T>();

  void push(T element) {
    _stack.addLast(element);
  }

  T top() {
    return _stack.last;
  }

  T pop() {
    T lastElement = _stack.last;
    _stack.removeLast();
    return lastElement;
  }
}

/* Implement part 1 */
int part1(List<int> code, int sz) {
  /* Create a hash set to store already seen sums */
  Map<int, int> seen = new HashMap();

  /* Loop through each entry */
  for (int i = 0; i < code.length; i++) {
    /* Fill the seen list, by adding sums of every already seen element less than i with i */
    int j = ((i - sz) >= 0) ? (i - sz) : 0;
    for (; j < (i - 1); j++) {
      int tmp = code[i - 1] + code[j];
      if (seen.containsKey(tmp))
        seen[tmp]++;
      else
        seen.putIfAbsent(tmp, () => 1);
    }

    /* If we've crossed the preamble */
    if (i >= sz) {
      /* Validating if we've seen this as a sum of 2 numbers */
      if (!seen.containsKey(code[i]) || (seen[code[i]] == 0)) return code[i];

      /* Remove the old sums that's now beyond the window */
      j = ((i - sz) >= 0) ? (i - sz) : 0;
      for (int k = j + 1; k < i; k++) {
        seen[(code[j] + code[k])]--;
      }
    }
  }

  /* We should never reach here */
  throw new Error();
}

/* Implement part 2 */
int part2(List<int> code, int sz) {
  int invalid = part1(code, sz);
  int st = 0;
  int en = 0;
  int sum = 0;

  /* Go into a loop */
  while ((st <= en) && (st < code.length) && (en < code.length)) {
    /* If sum is lesser, then add more by increasing en */
    if (sum < invalid) {
      sum += code[en];
      en++;
      /* If sum is more, then subtract by increasing st */
    } else if (sum > invalid) {
      sum -= code[st];
      st++;
      /* If we've found the target */
    } else {
      int minVal = code[st];
      int maxVal = code[st];
      for (int i = st + 1; i < en; i++) {
        minVal = min(minVal, code[i]);
        maxVal = max(maxVal, code[i]);
      }
      return (minVal + maxVal);
    }
  }

  throw new Error();
}

/** Application entry point */
void main() {
  const path = "input.txt";
  int preambleSz = 25;
  List<int> code = new List();
  new File(path)
      .openRead()
      .map(utf8.decode)
      .transform(new LineSplitter())
      .forEach((element) => code.add(int.parse(element)))
      .then((value) => print('Part1: ${part1(code, preambleSz)}'))
      .then((value) => print('Part2: ${part2(code, preambleSz)}'));
}
