// DO NOT EDIT. This is code generated via package:gen_lang/generate.dart

import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'messages_all.dart';

class S {
 
  static const GeneratedLocalizationsDelegate delegate = GeneratedLocalizationsDelegate();

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }
  
  static Future<S> load(Locale locale) {
    final String name = locale.countryCode == null ? locale.languageCode : locale.toString();

    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new S();
    });
  }
  
  String get locale {
    return Intl.message('en', name: 'locale');
  }

  String get messageOnly {
    return Intl.message('This is a message', name: 'messageOnly');
  }

  String messageHasParam(parameter) {
    return Intl.message('Message with parameter - ${parameter}', name: 'messageHasParam', args: [parameter]);
  }

  String pluralMsg(howMany) {
    return Intl.plural(howMany,
        zero: 'No message',
        one: '${howMany} message',
        two: '${howMany} messages',
        few: '${howMany} few messages',
        many: 'Many message',
        other: '${howMany} messages',
        name: 'pluralMsg',
        args: [howMany]);
  }

  String pluralMsgWithParam(howMany, yourName) {
    return Intl.plural(howMany,
        zero: null,
        one: 'Hi, ${yourName}! Get one message',
        two: null,
        few: null,
        many: null,
        other: 'Hi, ${yourName}! Get ${howMany} message',
        name: 'pluralMsgWithParam',
        args: [howMany, yourName]);
  }

  String genderWithParam(targetGender, yourName) {
    return Intl.gender(targetGender,
        male: 'Hi, ${yourName}! You are Male',
        female: 'Hi, ${yourName}! You are Female',
        other: 'Hi, ${yourName}! You maybe Male or Female',
        name: 'genderWithParam',
        args: [targetGender, yourName]);
  }


}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<S> {
  const GeneratedLocalizationsDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
			Locale("en", ""),
			Locale("ja", ""),
			Locale("zh", "TW"),

    ];
  }

  LocaleListResolutionCallback listResolution({Locale fallback}) {
    return (List<Locale> locales, Iterable<Locale> supported) {
      if (locales == null || locales.isEmpty) {
        return fallback ?? supported.first;
      } else {
        return _resolve(locales.first, fallback, supported);
      }
    };
  }

  LocaleResolutionCallback resolution({Locale fallback}) {
    return (Locale locale, Iterable<Locale> supported) {
      return _resolve(locale, fallback, supported);
    };
  }

  Locale _resolve(Locale locale, Locale fallback, Iterable<Locale> supported) {
    if (locale == null || !isSupported(locale)) {
      return fallback ?? supported.first;
    }

    final Locale languageLocale = Locale(locale.languageCode, "");
    if (supported.contains(locale)) {
      return locale;
    } else if (supported.contains(languageLocale)) {
      return languageLocale;
    } else {
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    }
  }

  @override
  Future<S> load(Locale locale) {
    return S.load(locale);
  }

  @override
  bool isSupported(Locale locale) =>
    locale != null && supportedLocales.contains(locale);

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => false;
}
