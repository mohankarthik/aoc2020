import 'dart:convert';
import 'dart:io';

/**
 * Class to hold a single bag rule
 */
class BagRule {
  String Name = "";
  Map<String, int> CanContain = Map<String, int>();

  /** 
   * Constructor that takes a single line of string, and decodes a bag rule from it
   */
  BagRule(String str) {
    /* Get the name */
    int nameEnd = str.indexOf(" bags contain ");
    this.Name = str.substring(0, nameEnd);

    /* Get the containers */
    final String containerSubStr = str.substring(nameEnd + 14);
    if (!containerSubStr.startsWith("no other bags")) {
      final containerStrs = containerSubStr.split(",");
      RegExp containerMatcher = RegExp(r"([1-9]+)( )([a-zA-Z ]*) ");
      for (final str in containerStrs) {
        final matches = containerMatcher.allMatches(str).elementAt(0);
        CanContain[matches.group(3)] = int.parse(matches.group(1));
      }
    }
  }

  /* Utility function to help print the rule */
  void Print() {
    print('**${this.Name}**');
    for (final contain in this.CanContain.entries) {
      print('${contain.key} -> ${contain.value}');
    }
    print('');
  }
}

/* Memoization for part 1 */
Map<String, bool> _memo1 = Map<String, bool>();

/* Implement the DFS traversal for part 1 with memoization to prever unnecessary recomputations */
bool traverse(List<BagRule> rules, String curr, String tar) {
  bool result = false;

  /* Check if we've already seen this */
  if (_memo1.containsKey(curr)) return _memo1[curr];

  /* Get the current rule */
  BagRule rule = rules.firstWhere((element) => element.Name == curr);

  /* Check if the current rule can directly contain our target */
  if (rule.CanContain.containsKey(tar)) {
    _memo1[curr] = true;
    return true;
  }

  /* Search through the sub containers */
  for (final sub in rule.CanContain.entries) {
    result |= traverse(rules, sub.key, tar);
  }

  /* Save */
  _memo1[curr] = result;

  /* Return it */
  return result;
}

/* Wrapper for the part 1. Invokes a DFS search from each node to check if we can reach our target node */
void part1(List<BagRule> rules, String target) {
  int result = 0;
  for (final rule in rules) {
    result += (traverse(rules, rule.Name, target)) ? 1 : 0;
  }
  print('Part1: ${result}');
}

/* Store the memoization for part 2 */
Map<String, int> _memo2 = Map<String, int>();

/**
 * Implement part 2 by implementing a DFS searching from our bag, and recursing and counting the total number of bags
 * that our bag would contain. It's important to memoize such that we don't recompute already computed values and
 * use dynamic programming to optimize the flow. 
 * With memoization, it should be O(N), without it worst case be exponential or factorial scale.
 */
int part2(List<BagRule> rules, String curr) {
  int result = 0;

  if (_memo2.containsKey(curr)) return _memo2[curr];

  /* Get the current rule */
  BagRule rule = rules.firstWhere((element) => element.Name == curr);

  for (final sub in rule.CanContain.entries) {
    result += sub.value + (sub.value * part2(rules, sub.key));
  }

  _memo2[curr] = result;

  return result;
}

/** Application entry point */
void main() {
  const path = "input.txt";
  List<BagRule> rules = new List();
  new File(path)
      .openRead()
      .map(utf8.decode)
      .transform(new LineSplitter())
      .forEach((element) => rules.add(BagRule(element)))
      .then((value) => part1(rules, "shiny gold"))
      .then((value) => print('Part2: ${part2(rules, "shiny gold")}'));
}
