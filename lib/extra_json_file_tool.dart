import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:gen_lang/print_tool.dart';
import 'package:path/path.dart' as path;

class Message {
  MessageKey messageKey;

  // Simple Message
  String message;

  // Plural
  String zero;
  String one;
  String two;
  String few;
  String many;
  String other;

  // Gender
  String male;
  String female;
  String genderOther;

  @override
  String toString() {
    return '_Message{message: $message, zero: $zero, one: $one, two: $two, few: $few, many: $many, other: $other}';
  }
}

class MessageKey {
  String key;
  MessageType type;
  SubType subType;

  MessageKey(this.key, this.type, this.subType);

  @override
  String toString() {
    return '_MessageKey{key: $key, type: $type}';
  }
}

enum MessageType { message, plural, gender }

enum SubType {
  pluralZero,
  pluralOne,
  pluralTwo,
  pluralFew,
  pluralMany,
  pluralOther,
  genderMale,
  genderFemale,
  genderOther
}

RegExp _FILE_NAMING_REGEXP = RegExp(r'string_\w+.json');

Map<String, FileSystemEntity> getValidStringFileMap(files) {
  Map<String, FileSystemEntity> validMap = {};
  for (FileSystemEntity file in files) {
//    path.basename(file.path);
//    printInfo('${file.path}');

    String fileName = path.basename(file.path);

    if (_validateStringFileName(fileName)) {
      String locale = getLocale(fileName);
      validMap[locale] = file;
//      printInfo('Basename : ${path.basename(file.path)}');
//      printInfo('locale : ${locale}');
    } else {
      printWarning(
          '$fileName does not match naming pattern [string_{locale}.json]');
    }
  }

  return validMap;
}

Future<List<FileSystemEntity>> dirContents(Directory dir) {
  List<FileSystemEntity> files = [];
  var completer = new Completer<List<FileSystemEntity>>();
  var lister = dir.list(recursive: false);
  lister.listen((file) => files.add(file),
      // should also register onError
      onDone: () => completer.complete(files));
  return completer.future;
}

FileSystemEntity getDefaultTemplateLang(
    Map<String, FileSystemEntity> validFilesMap, String lang) {
  FileSystemEntity defaultFile = validFilesMap[lang];
  if (defaultFile != null) {
    return defaultFile;
  }

  for (FileSystemEntity defaultFile in validFilesMap.values) {
    return defaultFile;
  }

  return null;
}

Future<Map<String, Message>> generateJsonKeyMessageMap(File jsonFile) async {
  Map<String, dynamic> jsonMap = jsonDecode(await jsonFile.readAsString());
  Map<String, Message> keyMap = {};

  for (MapEntry<String, dynamic> jsonEntry in jsonMap.entries) {
    String k = jsonEntry.key;
    String v = jsonEntry.value;

    MessageKey _messageKey = getMessageKey(k);
    Message _message;
    if (keyMap.containsKey(_messageKey.key)) {
      _message = keyMap[_messageKey.key];
    } else {
      _message = Message();
      _message.messageKey = _messageKey;
      keyMap[_messageKey.key] = _message;
    }

    switch (_messageKey.type) {
      case MessageType.plural:
        {
          switch (_messageKey.subType) {
            case SubType.pluralOne:
              {
                _message.one = v;
                break;
              }
            case SubType.pluralFew:
              {
                _message.few = v;
                break;
              }
            case SubType.pluralMany:
              {
                _message.many = v;
                break;
              }
            case SubType.pluralOther:
              {
                _message.other = v;
                break;
              }
            case SubType.pluralZero:
              {
                _message.zero = v;
                break;
              }
            case SubType.pluralTwo:
              {
                _message.two = v;
                break;
              }
            default:
              {
                break;
              }
          }
          break;
        }
      case MessageType.gender:
        {
          switch (_messageKey.subType) {
            case SubType.genderMale:
              {
                _message.male = v;
                break;
              }
            case SubType.genderFemale:
              {
                _message.female = v;
                break;
              }
            case SubType.genderOther:
              {
                _message.genderOther = v;
                break;
              }
            default:
              {
                break;
              }
          }
          break;
        }
      default:
        {
          _message.message = v;
          break;
        }
    }
  }

  return keyMap;
}

MessageKey getMessageKey(String jsonKey) {
  String key;
  MessageType type;
  SubType subType;

  if (jsonKey.endsWith('One')) {
    key = jsonKey.substring(0, jsonKey.lastIndexOf('One'));
    type = MessageType.plural;
    subType = SubType.pluralOne;
  } else if (jsonKey.endsWith('Few')) {
    key = jsonKey.substring(0, jsonKey.lastIndexOf('Few'));
    type = MessageType.plural;
    subType = SubType.pluralFew;
  } else if (jsonKey.endsWith('Many')) {
    key = jsonKey.substring(0, jsonKey.lastIndexOf('Many'));
    type = MessageType.plural;
    subType = SubType.pluralMany;
  } else if (jsonKey.endsWith('POther')) {
    key = jsonKey.substring(0, jsonKey.lastIndexOf('POther'));
    type = MessageType.plural;
    subType = SubType.pluralOther;
  } else if (jsonKey.endsWith('Zero')) {
    key = jsonKey.substring(0, jsonKey.lastIndexOf('Zero'));
    type = MessageType.plural;
    subType = SubType.pluralZero;
  } else if (jsonKey.endsWith('Two')) {
    key = jsonKey.substring(0, jsonKey.lastIndexOf('Two'));
    type = MessageType.plural;
    subType = SubType.pluralTwo;
  } else if (jsonKey.endsWith('Male')) {
    key = jsonKey.substring(0, jsonKey.lastIndexOf('Male'));
    type = MessageType.gender;
    subType = SubType.genderMale;
  } else if (jsonKey.endsWith('Female')) {
    key = jsonKey.substring(0, jsonKey.lastIndexOf('Female'));
    type = MessageType.gender;
    subType = SubType.genderFemale;
  } else if (jsonKey.endsWith('GOther')) {
    key = jsonKey.substring(0, jsonKey.lastIndexOf('GOther'));
    type = MessageType.gender;
    subType = SubType.genderOther;
  } else {
    key = jsonKey;
    type = MessageType.message;
  }

  return MessageKey(key, type, subType);
}

String getLocale(String fileName) {
  return fileName.replaceAll('string_', '').replaceAll('.json', '');
}

bool _validateStringFileName(String fileName) {
  return _FILE_NAMING_REGEXP.hasMatch(fileName);
}
