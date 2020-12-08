import 'dart:collection';
import 'dart:io';
import 'dart:convert';

class HHCInst {
  String Inst;
  int Arg;
  String FullInst;

  HHCInst(String str) {
    RegExp matcher = RegExp(r"^(nop|acc|jmp) (\+|-)([0-9]+)$");
    final matches = matcher.allMatches(str);
    if (matches.length == 0) throw Error();
    if (matches.elementAt(0).groupCount != 3) throw Error();
    Inst = matches.elementAt(0).group(1);
    Arg = (matches.elementAt(0).group(2) == '-')
        ? -int.parse(matches.elementAt(0).group(3))
        : int.parse(matches.elementAt(0).group(3));
    FullInst = str;
  }

  void Print() {
    print('$Inst -> $Arg');
  }
}

class Computer {
  int _acc = 0;
  List<HHCInst> _code = List();
  int _pc = 0;

  /* Initializes the computer */
  Computer(List<HHCInst> code) {
    _code.addAll(code);
  }

  HHCInst CurrentInst() {
    return _code[_pc];
  }

  int GetAcc() {
    return _acc;
  }

  int GetPC() {
    return _pc;
  }

  /* Performs a single step */
  void Step() {
    String inst = _code[_pc].Inst;
    int Arg = _code[_pc].Arg;
    if (inst == "nop") {
      _pc++;
    } else if (inst == "acc") {
      _acc += Arg;
      _pc++;
    } else {
      _pc += Arg;
    }
  }

  /* Resets the computer back to 0 */
  void Reset() {
    _pc = 0;
  }

  /* Self checks if there is a loop */
  bool IsLoop() {
    Set<int> seen = new HashSet();

    /* Reset the computer */
    Reset();

    while (_pc < _code.length && _pc >= 0) {
      /* Mark this as seen */
      seen.add(_pc);

      /* Step next */
      Step();

      /* If already seen, then we've a loop */
      if (seen.contains(_pc)) return true;
    }

    return false;
  }
}

void part1(List<HHCInst> code) {
  Computer computer = Computer(code);
  if (computer.IsLoop() == true) print('Part1: ${computer.GetAcc()}');
}

void part2(List<HHCInst> code) {
  String orig = "";
  for (var line in code) {
    if (line.Inst == "acc") {
      continue;
    } else if (line.Inst == "nop") {
      orig = "nop";
      line.Inst = "jmp";
    } else if (line.Inst == "jmp") {
      orig = "jmp";
      line.Inst = "nop";
    }
    Computer computer = Computer(code);
    if (computer.IsLoop() == false) {
      print('Part2: ${computer.GetAcc()}');
      break;
    } else {
      line.Inst = orig;
    }
  }
}

void main() {
  const path = "input.txt";
  List<HHCInst> code = new List();
  new File(path)
      .openRead()
      .map(utf8.decode)
      .transform(new LineSplitter())
      .forEach((element) => code.add(HHCInst(element)))
      .then((value) => part1(code))
      .then((value) => part2(code));
}
