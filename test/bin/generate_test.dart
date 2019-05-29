import 'package:test/test.dart';
import '../../bin/generate.dart';


void main() {
  group('Testing bin/generate.dart', () {
    test('Does not show help message when empty arguments', () {
      List<String> arg = [];
      expect(isHelpCommand(arg), equals(false));
    });
  });
}