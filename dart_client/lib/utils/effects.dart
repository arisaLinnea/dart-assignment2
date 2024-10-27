import 'dart:io';

// Text color codes
const black = '\x1B[30m';
const red = '\x1B[31m';
const green = '\x1B[32m';
const yellow = '\x1B[33m';
const blue = '\x1B[34m';
const magenta = '\x1B[35m';
const cyan = '\x1B[36m';
const white = '\x1B[37m';

//Bright text colors
const brightBlack = '\x1B[90m';
const brightRed = '\x1B[91m';
const brightGreen = '\x1B[92m';
const brightYellow = '\x1B[93m';
const brightBlue = '\x1B[94m';
const brightMagenta = '\x1B[95m';
const brightCyan = '\x1B[96m';
const brightWhite = '\x1B[97m';

// BG color codes
const blackBG = '\x1B[40m';
const redBG = '\x1B[41m';
const greenBG = '\x1B[42m';
const yellowBG = '\x1B[43m';
const blueBG = '\x1B[44m';
const magentaBG = '\x1B[45m';
const cyanBG = '\x1B[46m';
const whiteBG = '\x1B[47m';

//style
const bold = '\x1B[1m';
const dim = '\x1B[2m';
const italic = '\x1B[3m';
const underline = '\x1B[4m';
const blink = '\x1B[5m';
const reverse = '\x1B[7m'; // (invert foreground and background)
const hidden = '\x1B[8m';
const strikethrough = '\x1B[9m';

const reset = '\x1B[0m'; // Reset

void printGreeting(String text) {
  print('$underline$bold$blue$text$reset');
}

void printAdd(String text) {
  print('Values thats been saved: $brightGreen$text$reset');
}

void printAction(String text) {
  print('$brightGreen$text$reset');
}

void printListInfo(String text) {
  print('$magenta$text$reset');
}

void printWarning(String text) {
  print('$yellow$text$reset');
}

void printError(String text) {
  print('$italic$red$text$reset');
}

void clearScreen() {
  // might not work on all platforms
  // print(Process.runSync("clear", [], runInShell: true).stdout);

  stdout.writeln('\x1B[2J\x1B[0;0H'); //safe on both mac and windows
}

void exitCli() {
  printGreeting('Thank you for choosing FindMeASpot!');
  exit(0);
}
