import 'dart:collection';
import 'dart:convert';
import 'dart:io';

/* Implement part 1 of the program */
void part1(List<List<String>> input) {
  /* Initialize the result */
  int result = 0;

  for (final group in input) {
    /* Create a hasset to store the unique elements */
    Set<String> unique = new HashSet();
    for (final person in group) {
      for (var idx = 0; idx < person.length; idx++) unique.add(person[idx]);
    }
    /* Add the total number of unique elements into our answer */
    result += unique.length;
  }

  print('Part1: $result');
}

/* Implement part 2 of the program */
void part2(List<List<String>> input) {
  /* Initialize the result */
  int result = 0;

  /* Loop through each group in the input */
  for (final group in input) {
    /* Loop through all the characters in the first person's form */
    for (int j = 0; j < group[0].length; j++) {
      /* Let's be optimistic */
      bool present = true;
      /* Loop through all the other person's forms */
      for (int k = 1; k < group.length; k++) {
        /* Check if whatever the first person has answered yes, is also answered in other person's forms */
        if (!group[k].contains(group[0][j])) {
          /* If not, so sad! They are out of xmas */
          present = false;
          break;
        }
      }
      /* If all have answered, update our list */
      if (present) result++;
    }
  }

  print('Part2: $result');
}

void main() {
  const path = "input.txt";
  List<List<String>> forms = new List();
  new File(path)
      .openRead()
      .map(utf8.decode)
      .forEach((element) => element.split("\r\n\r\n").forEach((form) {
            forms.add(form.split("\r\n"));
          }))
      .then((value) => part1(forms))
      .then((value) => part2(forms));
}
