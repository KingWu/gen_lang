// DO NOT EDIT. This is code generated via package:gen_lang/generate.dart

import 'dart:async';

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';
// ignore: implementation_imports
import 'package:intl/src/intl_helpers.dart';

final _$ja = $ja();

class $ja extends MessageLookupByLibrary {
  get localeName => 'ja';
  
  final messages = {
		"genderMessage" : (targetGender, name) => "${Intl.genderLogic(targetGender, male: 'こんにちは${name}、彼は男です。', female: 'こんにちは${name}、彼女は女性です。', other: 'こんにちは${name}、彼/彼女は男性/女性です。')}",
		"locale" : MessageLookupByLibrary.simpleMessage("日文"),
		"messageWithParams" : (yourName) => "こんにちは${yourName}、ようこそ。",
		"pluralMessage" : (howMany, interviewerName) => "${Intl.pluralLogic(howMany, zero: null, one: 'こんにちは${interviewerName}、仕事の経験がありません。', two:null, few:null, many:null, other: 'こんにちは${interviewerName}、私は${howMany}年の実務経験があります。')}",
		"simpleMessage" : MessageLookupByLibrary.simpleMessage("これは簡単なメッセージです"),

  };
}

final _$zh_TW = $zh_TW();

class $zh_TW extends MessageLookupByLibrary {
  get localeName => 'zh_TW';
  
  final messages = {
		"genderMessage" : (targetGender, name) => "${Intl.genderLogic(targetGender, male: '你好 ${name}，他是男。', female: '你好 ${name}，她是女。', other: '你好 ${name}，他/她是男/女。')}",
		"locale" : MessageLookupByLibrary.simpleMessage("中文"),
		"messageWithParams" : (yourName) => "你好 ${yourName}，歡迎你。",
		"pluralMessage" : (howMany, interviewerName) => "${Intl.pluralLogic(howMany, zero: null, one: '你好 ${interviewerName}，我沒有工作經驗。', two:null, few:null, many:null, other: '你好 ${interviewerName}，我有${howMany}年工作經驗。')}",
		"simpleMessage" : MessageLookupByLibrary.simpleMessage("這是簡單消息"),

  };
}

final _$en = $en();

class $en extends MessageLookupByLibrary {
  get localeName => 'en';
  
  final messages = {
		"genderMessage" : (targetGender, name) => "${Intl.genderLogic(targetGender, male: 'Hi ${name}, He is boy.', female: 'Hi ${name}, She is girl.', other: 'Hi ${name}, he/she is boy/girl.')}",
		"locale" : MessageLookupByLibrary.simpleMessage("English"),
		"messageWithParams" : (yourName) => "Hi ${yourName}, Welcome you!",
		"pluralMessage" : (howMany, interviewerName) => "${Intl.pluralLogic(howMany, zero: null, one: 'Hi ${interviewerName}, I have one year working experience.', two:null, few:null, many:null, other: 'Hi ${interviewerName}, I have ${howMany} years of working experience.')}",
		"simpleMessage" : MessageLookupByLibrary.simpleMessage("This is a simple Message"),

  };
}



typedef Future<dynamic> LibraryLoader();
Map<String, LibraryLoader> _deferredLibraries = {
	"ja": () => Future.value(null),
	"zh_TW": () => Future.value(null),
	"en": () => Future.value(null),

};

MessageLookupByLibrary _findExact(localeName) {
  switch (localeName) {
    case "ja":
        return _$ja;
    case "zh_TW":
        return _$zh_TW;
    case "en":
        return _$en;

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
