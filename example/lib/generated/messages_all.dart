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
		"locale" : MessageLookupByLibrary.simpleMessage("ja"),
		"messageOnly" : MessageLookupByLibrary.simpleMessage("これはメッセージです"),
		"messageHasParam" : (parameter) => "パラメータ付きメッセージ -  ${parameter}",
		"pluralMsg" : (howMany) => "${Intl.pluralLogic(howMany, zero: 'メッセージなし', one: '${howMany} メッセージ', two:'${howMany} メッセージ', few:'${howMany} メッセージ', many:'多くのメッセージ', other: '${howMany} メッセージ')}",
		"pluralMsgWithParam" : (howMany, yourName) => "${Intl.pluralLogic(howMany, zero: null, one: 'こんにちは, ${yourName}! メッセージを受け取りました', two:null, few:null, many:null, other: 'こんにちは, ${yourName}! ${howMany} メッセージを受信しました')}",
		"genderWithParam" : (targetGender, yourName) => "${Intl.genderLogic(targetGender, male: 'こんにちは, ${yourName}! あなたは男です', female: 'こんにちは, ${yourName}! あなたは女性です', other: 'こんにちは, ${yourName}! あなたは男性か女性です')}",

  };
}

final _$zh_TW = $zh_TW();

class $zh_TW extends MessageLookupByLibrary {
  get localeName => 'zh_TW';
  
  final messages = {
		"locale" : MessageLookupByLibrary.simpleMessage("zh_TW"),
		"messageOnly" : MessageLookupByLibrary.simpleMessage("這是一條消息"),
		"messageHasParam" : (parameter) => "帶參數的消息 -  ${parameter}",
		"pluralMsg" : (howMany) => "${Intl.pluralLogic(howMany, zero: '沒有消息', one: '${howMany} 消息', two:'${howMany} 消息', few:'${howMany} 消息', many:'很多消息', other: '${howMany} 消息')}",
		"pluralMsgWithParam" : (howMany, yourName) => "${Intl.pluralLogic(howMany, zero: null, one: '你好, ${yourName}! 收到一個消息', two:null, few:null, many:null, other: '你好, ${yourName}! 收到 ${howMany} 消息')}",
		"genderWithParam" : (targetGender, yourName) => "${Intl.genderLogic(targetGender, male: '你好, ${yourName}! 你是男', female: '你好, ${yourName}! 你是女', other: '你好, ${yourName}! 你是男或女')}",

  };
}

final _$en = $en();

class $en extends MessageLookupByLibrary {
  get localeName => 'en';
  
  final messages = {
		"locale" : MessageLookupByLibrary.simpleMessage("en"),
		"messageOnly" : MessageLookupByLibrary.simpleMessage("This is a message"),
		"messageHasParam" : (parameter) => "Message with parameter - ${parameter}",
		"pluralMsg" : (howMany) => "${Intl.pluralLogic(howMany, zero: 'No message', one: '${howMany} message', two:'${howMany} messages', few:'${howMany} few messages', many:'Many message', other: '${howMany} messages')}",
		"pluralMsgWithParam" : (howMany, yourName) => "${Intl.pluralLogic(howMany, zero: null, one: 'Hi, ${yourName}! Get one message', two:null, few:null, many:null, other: 'Hi, ${yourName}! Get ${howMany} message')}",
		"genderWithParam" : (targetGender, yourName) => "${Intl.genderLogic(targetGender, male: 'Hi, ${yourName}! You are Male', female: 'Hi, ${yourName}! You are Female', other: 'Hi, ${yourName}! You maybe Male or Female')}",

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
