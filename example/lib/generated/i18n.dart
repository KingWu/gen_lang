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
  
  String genderMessage(targetGender, name) {
    return Intl.gender(targetGender,
        male: 'Hi ${name}, He is boy.',
        female: 'Hi ${name}, She is girl.',
        other: 'Hi ${name}, he/she is boy/girl.',
        name: 'genderMessage',
        args: [targetGender, name]);
  }

  String get locale {
    return Intl.message('English', name: 'locale');
  }

  String messageWithParams(yourName) {
    return Intl.message('Hi ${yourName}, Welcome you!', name: 'messageWithParams', args: [yourName]);
  }

  String pluralMessage(howMany, interviewerName) {
    return Intl.plural(howMany,
        zero: null,
        one: 'Hi ${interviewerName}, I have one year working experience.',
        two: null,
        few: null,
        many: null,
        other: 'Hi ${interviewerName}, I have ${howMany} years of working experience.',
        name: 'pluralMessage',
        args: [howMany, interviewerName]);
  }

  String get simpleMessage {
    return Intl.message('This is a simple Message', name: 'simpleMessage');
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
