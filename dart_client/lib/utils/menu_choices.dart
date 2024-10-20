import 'dart:io';

import 'package:dart_client/utils/effects.dart';
import 'package:dart_client/utils/validator.dart';

void printContinue() {
  stdout.write('Press enter to see options again. ');
  stdin.readLineSync();
  clearScreen();
}

String checkInputStringValues({required String question}) {
  String? inputValue;
  while (inputValue == "" || inputValue == null) {
    stdout.write(question);
    inputValue = stdin.readLineSync();
    if (inputValue == "") {
      printError('Invalid input. Please fill in missing value.');
    }
  }
  return inputValue;
}

String checkInputSsnValues({required String question}) {
  String? inputValue;
  while (inputValue == "" || inputValue == null) {
    stdout.write(question);
    inputValue = stdin.readLineSync();
    print(validateSsn(inputValue) ? 'validat ssn true' : 'validate ssn false');
    if (inputValue == "" || !validateSsn(inputValue)) {
      inputValue = "";
      printError('Invalid input. Please fill in a valid ssn, eg YYMMDDNNNN.');
    }
  }
  return inputValue;
}

String checkInputRegNoValues({required String question}) {
  String? inputValue;
  while (inputValue == "" || inputValue == null) {
    stdout.write(question);
    inputValue = stdin.readLineSync();
    if (inputValue == "" || !validateRegNo(inputValue)) {
      inputValue = "";
      printError('Invalid input. Please fill in a regNo.');
    }
  }
  return inputValue;
}

bool checkBoolOption({required String question}) {
  stdout.write(question);
  String? input = stdin.readLineSync();
  if (input == 'y' || input == "Y") {
    return true;
  }
  return false;
}

void menuOption(List<dynamic> userOptions) {
  userOptions.forEach(stdout.writeln);
}

void listOption(List<dynamic> list) {
  for (final (index, item) in list.indexed) {
    print("${index + 1}. $item");
  }
}

int checkIntOption(
    {required int maxNumber,
    required List<dynamic> userOptions,
    required String question,
    required bool menu}) {
  int? numberChoosen;
  while (numberChoosen == null) {
    menu ? menuOption(userOptions) : listOption(userOptions);
    stdout.write(question);
    String? input = stdin.readLineSync();
    if (menu && (input == 'q' || input == "Q")) {
      exitCli();
    }
    if (input == null ||
        int.tryParse(input) == null ||
        int.parse(input) < 1 ||
        int.parse(input) > maxNumber) {
      clearScreen();
      printError(
          'You entered "$input", but need to choose a number between 1-$maxNumber');
      continue;
    }
    numberChoosen = int.parse(input);
  }
  return numberChoosen;
}

double checkDoubleOption({required String question}) {
  double? numberChoosen;
  while (numberChoosen == null) {
    stdout.write(question);
    String? input = stdin.readLineSync();
    if (input == null || input == "" || double.tryParse(input) == null) {
      print(
          'You entered "$input", but need to choose a valid float/integer number');
      continue;
    }
    numberChoosen = double.parse(input);
  }
  return numberChoosen;
}

int checkHourOption({required String question}) {
  int? numberChoosen;
  while (numberChoosen == null) {
    stdout.write(question);
    String? input = stdin.readLineSync();
    if (input == null ||
        input == "" ||
        int.tryParse(input) == null ||
        int.parse(input) < 0) {
      print(
          'You entered "$input", but need to choose a valid (positive integer) number');
      continue;
    }
    numberChoosen = int.parse(input);
  }
  return numberChoosen;
}

int checkMinuteOption({required String question}) {
  int? numberChoosen;
  while (numberChoosen == null) {
    stdout.write(question);
    String? input = stdin.readLineSync();
    if (input == null ||
        input == "" ||
        int.tryParse(input) == null ||
        int.parse(input) < 0 ||
        int.parse(input) > 59) {
      print(
          'You entered "$input", but need to choose a valid (positive integer) number under 60');
      continue;
    }
    numberChoosen = int.parse(input);
  }
  return numberChoosen;
}
