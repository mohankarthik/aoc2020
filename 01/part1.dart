import 'dart:collection';
import 'dart:io';
import 'dart:convert';

/* Setup the hash set to save the data */
Set mem = new HashSet();

/* Function to process each input as it comes in */
void process(int aNumber) {
  if (mem.contains(2020 - aNumber)) {
    print(aNumber * (2020 - aNumber));
    exit(0);
  } else {
    mem.add(aNumber);
  }
}

/* Application entry point */
void main() {
  /* Read the file */
  const path = "input.txt";
  new File(path)
      .openRead()
      .map(utf8.decode)
      .transform(new LineSplitter())
      .forEach((element) => process(int.parse(element)));
}
