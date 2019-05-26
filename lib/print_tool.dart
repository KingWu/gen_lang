library print_tool;

import 'package:ansicolor/ansicolor.dart';

void printInfo(String info) {
  AnsiPen pen = new AnsiPen()..gray();
  print(pen('[INFO]: $info'));
}

void printWarning(String warning) {
  AnsiPen pen = new AnsiPen()..yellow();
  print(pen('[WARNING]: $warning'));
}

void printError(String error) {
  AnsiPen pen = new AnsiPen()..red();
  print(pen('[ERROR]: $error'));
}
