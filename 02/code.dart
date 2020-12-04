import 'dart:convert';
import 'dart:io';

/* Global to track the valid passwords */
int validPasswords = 0;

/* Class to manage the password data */
class PassData {
  int minVal;
  int maxVal;
  String char;
  String pwd;

  /* Default constructor */
  PassData(this.minVal, this.maxVal, this.char, this.pwd);

  /* Constructor that takes the string input */
  PassData.fromString(String str) {
    /* Do a regexp matcher */
    RegExp matcher = RegExp(r'([0-9]+)-([0-9]+) ([a-z]): ([a-z]+)');
    Iterable<Match> matches = matcher.allMatches(str);

    /* Extract the values */
    this.minVal = int.parse(matches.elementAt(0).group(1));
    this.maxVal = int.parse(matches.elementAt(0).group(2));
    this.char = matches.elementAt(0).group(3);
    this.pwd = matches.elementAt(0).group(4);
  }
}

/* Code for part 1 of the problem */
void part1(String str) {
  /* Dissect the data */
  PassData data = PassData.fromString(str);

  /* Check for validity */
  var count = 0;
  for (int i = 0; i < data.pwd.length; i++) {
    if (data.pwd[i] == data.char) {
      count = count + 1;
    }
  }

  if ((count >= data.minVal) && (count <= data.maxVal)) validPasswords++;
}

/* Code for part 2 of the problem */
void part2(String str) {
  /* Dissect the data */
  PassData data = PassData.fromString(str);

  /* Check for validity */
  if ((data.pwd[data.minVal - 1] == data.char) ^
      (data.pwd[data.maxVal - 1] == data.char)) validPasswords++;
}

void main() {
  /* Read the file */
  const path = "input.txt";
  new File(path)
      .openRead()
      .map(utf8.decode)
      .transform(new LineSplitter())
      .forEach((element) => part2(element))
      .then((value) => print(validPasswords));
}
