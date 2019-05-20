import 'package:gen_lang/extra_json_message_tool.dart';

String generateMessageAllDart(String createdMessageLookup, String deferredLibraries, String findExacts){
  return '''
// DO NOT EDIT. This is code generated via package:gen_lang/generate.dart

import 'dart:async';

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';
// ignore: implementation_imports
import 'package:intl/src/intl_helpers.dart';

$createdMessageLookup

typedef Future<dynamic> LibraryLoader();
Map<String, LibraryLoader> _deferredLibraries = {
$deferredLibraries
};

MessageLookupByLibrary _findExact(localeName) {
  switch (localeName) {
$findExacts
    default:
      return null;
  }
}

/// User programs should call this before using [localeName] for messages.
Future<bool> initializeMessages(String localeName) async {
  var availableLocale = Intl.verifiedLocale(
      localeName,
          (locale) => _deferredLibraries[locale] != null,
      onFailure: (_) => null);
  if (availableLocale == null) {
    return Future.value(false);
  }
  var lib = _deferredLibraries[availableLocale];
  await (lib == null ? Future.value(false) : lib());

  initializeInternalMessageLookup(() => CompositeMessageLookup());
  messageLookup.addLocale(availableLocale, _findGeneratedMessagesFor);

  return Future.value(true);
}

bool _messagesExistFor(String locale) {
  try {
    return _findExact(locale) != null;
  } catch (e) {
    return false;
  }
}

MessageLookupByLibrary _findGeneratedMessagesFor(locale) {
  var actualLocale = Intl.verifiedLocale(locale, _messagesExistFor,
      onFailure: (_) => null);
  if (actualLocale == null) return null;
  return _findExact(actualLocale);
}
''';
}

String generateMessageLookup(String locale, {String message = ''}){
  return '''
final _\$$locale = \$$locale();

class \$$locale extends MessageLookupByLibrary {
  get localeName => '$locale';
  
  final messages = {
$message
  };
}
''';
}

String generateKeyWithValue(String key, String value){
  return '''\t\t"$key" : $value,''';
}

String generateSimpleMessage(String message){
  return '''MessageLookupByLibrary.simpleMessage("${normalizedJsonMessage(message)}")''';
}

String generateMessageFunction(String args, String message){
  return '''($args) => "${normalizedJsonMessage(message)}"''';
}

String generatePluralFunction(String args, String zero, String one, String two, String few, String many, String other){

  var zeroArg = generateArg(normalizedJsonMessage(zero));
  var oneArg = generateArg(normalizedJsonMessage(one));
  var twoArg = generateArg(normalizedJsonMessage(two));
  var fewArg = generateArg(normalizedJsonMessage(few));
  var manyArg = generateArg(normalizedJsonMessage(many));
  var otherArg = generateArg(normalizedJsonMessage(other));

  return '''($args) => "\${Intl.pluralLogic(howMany, zero: $zeroArg, one: $oneArg, two:$twoArg, few:$fewArg, many:$manyArg, other: $otherArg)}"''';
}

String generateGenderFunction(String args, String male, String female, String other){

  var maleArg = generateArg(normalizedJsonMessage(male));
  var femaleArg = generateArg(normalizedJsonMessage(female));
  var otherArg = generateArg(normalizedJsonMessage(other));

  return '''($args) => "\${Intl.genderLogic(targetGender, male: $maleArg, female: $femaleArg, other: $otherArg)}"''';
}

String generateDeferredLibrariesLibrary(String locale){
  return '''\t"$locale": () => Future.value(null),''';
}

String generateFindExact(String locale){
  return '''
    case "$locale":
        return _\$$locale;''';
}

bool hasArgsInMessage(String message){
  return ARG_REG_EXP.hasMatch(message);
}

bool hasArgsInPlural(String zero, String one, String two, String few, String many, String other){
  List<String> plurals = [zero, one, two, few, many, other];

  for(String plural in plurals){
    if(null != plural && ARG_REG_EXP.hasMatch(plural)){
      return true;
    }
  }
  return false;
}



