import 'package:args/args.dart';
import 'package:gen_lang/core_18n.dart';

main(List<String> args) async {
  if (isHelpCommand(args)) {
    printHelperDisplay();
  } else {
    handleGenerateI18nFiles(generateI18Option(args));
  }
}

bool isHelpCommand(List<String> args) {
  return args.length == 1 && (args[0] == '--help' || args[0] == '-h');
}

void printHelperDisplay() {
  var parser = generateArgParser(null);
  print(parser.usage);
}

I18nOption generateI18Option(List<String> args) {
  I18nOption i18nOption = I18nOption();
  var parser = generateArgParser(i18nOption);
  parser.parse(args);
  return i18nOption;
}

ArgParser generateArgParser(I18nOption i18nOption) {
  var parser = new ArgParser();

  parser.addOption('source-dir',
      defaultsTo: 'res/string',
      callback: (String x) => i18nOption.sourceDir = x,
      help: 'A source folder contains all string json files');

  parser.addOption('output-dir',
      defaultsTo: 'lib/generated',
      callback: (String x) => i18nOption.outputDir = x,
      help: 'A output folder stores all generated files');

  parser.addOption('template-locale',
      defaultsTo: 'en',
      callback: (String x) => i18nOption.templateLocale = x,
      help:
          'Use string_{template-locale}.json as a template for default value when a locale does not exist. If string_en does not exist, this script will use the first string json file as a template');

  return parser;
}
