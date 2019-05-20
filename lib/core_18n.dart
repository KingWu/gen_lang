library core_18n;

import 'dart:io';
import 'package:gen_lang/extra_json_message_tool.dart';
import 'package:gen_lang/generate_i18n_dart.dart';
import 'package:gen_lang/generate_message_all.dart';
import 'package:gen_lang/print_tool.dart';
import 'package:gen_lang/extra_json_file_tool.dart';

import 'package:path/path.dart' as path;


class I18nOption {
  String sourceDir;
  String templateLocale;
  String outputDir;

  @override
  String toString() {
    return 'I18nOption{sourceDir: $sourceDir, templateLocale: $templateLocale, outputDir: $outputDir}';
  }
}

void handleGenerateI18nFiles(I18nOption option) async{
  Directory current = Directory.current;

  var sourcePath = Directory(path.join(current.path, option.sourceDir));
  if(!await sourcePath.exists()){
    printError('Source path does not exist');
    return;
  }

  List<FileSystemEntity> files = await dirContents(Directory(path.join(current.path, option.sourceDir)));
  Map<String, FileSystemEntity> validFilesMap = getValidStringFileMap(files);
  FileSystemEntity defaultTemplateLang = getDefaultTemplateLang(validFilesMap, option.templateLocale);
  if(null != defaultTemplateLang){
    Map<String, Message> defaultJsonKeyMessageMap = await generateJsonKeyMessageMap(File(defaultTemplateLang.path));
//    printInfo(defaultJsonKeyMessageMap.toString());
//    printInfo('outputDir: ${option.outputDir}');

    String defaultLang = path.basename(getLocale(defaultTemplateLang.path));

    // Generate messages_all.dart
    _handleGenerateMessageAllDart(
        path.join(current.path, option.outputDir, 'messages_all.dart'),
        defaultLang,
        defaultJsonKeyMessageMap,
        validFilesMap
    );

    // Generate i18n.dart
    _handleGenerateI18nDart(
        path.join(current.path, option.outputDir, 'i18n.dart'),
        defaultLang,
        defaultJsonKeyMessageMap,
        validFilesMap
    );

    printInfo('Finished to generate 2 files.');
  }
}

void _handleGenerateMessageAllDart(String path, String defaultLang, Map<String, Message> defaultKeyMap, Map<String, FileSystemEntity> validFilesMap) async{

  File generatedFile = File(path);
  if(!generatedFile.existsSync()){
    generatedFile.createSync(recursive: true);
  }

  StringBuffer createMessageLookupClassBuilder = StringBuffer();
  StringBuffer deferredLibrariesBuilder = StringBuffer();
  StringBuffer findExactBuilder = StringBuffer();

  // loop
  // 1.  generate all message lookup class
  // 2. generate message lookup instance
  // 3. generate deferredLibraries
  // 4. generate exact
  // loop end
  for(MapEntry<String, FileSystemEntity> mapEntry in validFilesMap.entries){
    String locale = mapEntry.key;
    FileSystemEntity fileEntity = mapEntry.value;

    Map<String, Message> jsonKeyMap;
    StringBuffer messageBuilder = StringBuffer();
    if(locale != defaultLang){
      jsonKeyMap = await generateJsonKeyMessageMap(File(fileEntity.path));
    }
    else{
      jsonKeyMap = defaultKeyMap;
    }

    for(MapEntry<String, Message> jsonKeyEntry in jsonKeyMap.entries){
      String jsonKey = jsonKeyEntry.key;
      Message message = jsonKeyEntry.value;

      switch(message.messageKey.type){
        case MessageType.message:{
          if(hasArgsInMessage(message.message)){
            messageBuilder.writeln(generateKeyWithValue(jsonKey, generateMessageFunction(extraArgsFromMessage(message.message), message.message)));
          }
          else{
            messageBuilder.writeln(generateKeyWithValue(jsonKey, generateSimpleMessage(message.message)));
          }
          break;
        }
        case MessageType.plural:{
          messageBuilder.writeln(
              generateKeyWithValue(
                  jsonKey,
                  generatePluralFunction(
                      extraArgsFromPlural(message.zero, message.one, message.two, message.few, message.many, message.other),
                      message.zero, message.one, message.two, message.few, message.many, message.other)));
          break;
        }
        case MessageType.gender:{
          messageBuilder.writeln(
              generateKeyWithValue(
                  jsonKey,
                  generateGenderFunction(
                      extraArgsFromGender(message.male, message.female, message.genderOther),
                      message.male, message.female, message.genderOther)));
          break;
        }
      }
    }

    deferredLibrariesBuilder.writeln(generateDeferredLibrariesLibrary(locale));
    findExactBuilder.writeln(generateFindExact(locale));
    createMessageLookupClassBuilder.writeln(generateMessageLookup(locale, message: messageBuilder.toString()));
  }

  // 5. generate messages_all.dart
  generatedFile.writeAsStringSync(generateMessageAllDart(
    createMessageLookupClassBuilder.toString(),
    deferredLibrariesBuilder.toString(),
    findExactBuilder.toString(),
  ));
}

void _handleGenerateI18nDart(String path, String defaultLang, Map<String, Message> defaultKeyMap, Map<String, FileSystemEntity> validFilesMap){
  File generatedFile = File(path);
  if(!generatedFile.existsSync()){
    generatedFile.createSync(recursive: true);
  }

  StringBuffer getterBuilder = StringBuffer();
  StringBuffer supportedLangBuilder = StringBuffer();

  // 1. Generate getters
  for(MapEntry<String, Message> entity in defaultKeyMap.entries){
    String jsonKey = entity.key;
    Message message = entity.value;

    switch(message.messageKey.type){
      case MessageType.message:{
        if(hasArgsInMessage(message.message)){
          getterBuilder.writeln(generateGetterMessageWithArgsFunction(jsonKey, message.message, extraArgsFromMessage(message.message)));
        }
        else{
          getterBuilder.writeln(generateGetterSimpleMessageFunction(jsonKey, message.message));
        }
        break;
      }
      case MessageType.plural:{
        getterBuilder.writeln(
            generateGetterPluralFunction(
                jsonKey,
                extraArgsFromPlural(message.zero, message.one, message.two, message.few, message.many, message.other),
                message.zero, message.one, message.two, message.few, message.many, message.other));
        break;
      }
      case MessageType.gender:{
        getterBuilder.writeln(
            generateGetterGenderFunction(
                jsonKey,
                extraArgsFromGender(message.male, message.female, message.genderOther),
                message.male, message.female, message.genderOther));
        break;
      }
    }
  }

  supportedLangBuilder.writeln(generateSupportedLocale(defaultLang));

  // 2. Generate supported locale
  for(var locale in validFilesMap.keys){
    if(locale != defaultLang){
      supportedLangBuilder.writeln(generateSupportedLocale(locale));
    }
  }

  // 3. Generate i18n.dart
  generatedFile.writeAsStringSync(generateI18nDart(
    getterBuilder.toString(),
    supportedLangBuilder.toString()
  ));
}