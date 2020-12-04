import 'dart:convert';
import 'dart:io';

class Passport {
  Map<String, String> _fields = Map();
  List<String> _requiredFields = [
    "byr",
    "iyr",
    "eyr",
    "hgt",
    "hcl",
    "ecl",
    "pid",
    //"cid"
  ];

  Passport(String str) {
    str.split('\r\n').forEach((element1) {
      element1.split(' ').forEach((element2) {
        final temp = element2.split(':');
        _fields[temp[0]] = temp[1];
      });
    });
  }

  bool IsValid() {
    for (final key in _requiredFields) {
      if (!_fields.containsKey(key)) {
        return false;
      }
    }
    return true;
  }

  bool IsReallyValid() {
    if (!IsValid()) return false;

    /* Check birth year */
    int byr = int.parse(_fields["byr"]);
    if ((byr < 1920) || (byr > 2002)) return false;

    /* Check issue year */
    int iyr = int.parse(_fields["iyr"]);
    if ((iyr < 2010) || (iyr > 2020)) return false;

    /* Check expiration year */
    int eyr = int.parse(_fields["eyr"]);
    if ((eyr < 2020) || (eyr > 2030)) return false;

    /* Check height */
    RegExp hgtRegEx = new RegExp(r"(^[1-9][0-9]*)(in|cm)$");
    if (!hgtRegEx.hasMatch(_fields["hgt"])) return false;
    final matches = hgtRegEx.allMatches(_fields["hgt"]).elementAt(0);
    int hgt = int.parse(matches.group(1));
    String hgtUnit = matches.group(2);
    if (hgtUnit == "in") {
      if ((hgt < 59) || (hgt > 76)) return false;
    } else {
      if ((hgt < 150) || (hgt > 193)) return false;
    }

    /* Check hair color */
    RegExp hclRegEx = new RegExp(r"^#[0-9a-fA-F]{6}$");
    if (!hclRegEx.hasMatch(_fields["hcl"])) return false;

    /* Check eye color */
    List<String> eyeColors = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"];
    if (!eyeColors.contains(_fields["ecl"])) return false;

    /* Check the PID */
    RegExp pidRegEx = new RegExp(r"^[0-9]{9}$");
    if (!pidRegEx.hasMatch(_fields["pid"])) return false;

    return true;
  }

  void Print() {
    _fields.forEach((key, value) {
      print('$key -> $value');
    });
  }
}

void part1(List<Passport> passports) {
  int valid = 0;
  passports.forEach((element) {
    if (element.IsValid()) valid++;
  });
  print('Part1: $valid');
}

void part2(List<Passport> passports) {
  int valid = 0;
  passports.forEach((element) {
    if (element.IsReallyValid()) valid++;
  });
  print('Part2: $valid');
}

void main() async {
  const path = "input.txt";
  List<Passport> passports = new List();
  new File(path)
      .openRead()
      .map(utf8.decode)
      .forEach((element) => passports
          .addAll(element.split("\r\n\r\n").map((e) => Passport(e)).toList()))
      .then((value) => part1(passports))
      .then((value) => part2(passports));
}
