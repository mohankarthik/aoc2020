import 'dart:collection';
import 'dart:io';
import 'dart:convert';

/* Setup the hash set to save the data */
Set mem = new HashSet();

/* Code for part 1 of the problem statement */
void part1(int aNumber) {
  if (mem.contains(2020 - aNumber)) {
    print(aNumber * (2020 - aNumber));
    exit(0);
  } else
    mem.add(aNumber);
}

/* Code for part 2 of the problem statement */
void part2(int aNumber1) {
  mem.forEach((aNumber2) {
    if (mem.contains(2020 - aNumber1 - aNumber2)) {
      print(aNumber1 * aNumber2 * (2020 - aNumber1 - aNumber2));
      exit(0);
    }
  });
  mem.add(aNumber1);
}

/* Application entry point */
void main() {
  /* Read the file */
  const path = "input.txt";
  new File(path)
      .openRead()
      .map(utf8.decode)
      .transform(new LineSplitter())
      .forEach((element) => part2(int.parse(element)));
}
