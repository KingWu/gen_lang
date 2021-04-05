import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gen_lang_example/generated/i18n.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  int index = 0;
  List<Locale> localeList = [Locale('en'), Locale('ja'), Locale('zh', 'TW')];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: localeList[index],
      home: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(S.of(context).locale),
            ),
            body: Center(
              child: Column(
                children: <Widget>[
                  Text(S.of(context).locale),
                  Text(S.of(context).simpleMessage),
                  Text(S.of(context).messageWithParams('developer')),
                  Text(S.of(context).pluralMessage(1, 'KingWu')),
                  Text(S.of(context).pluralMessage(10, 'KingWu')),
                  Text(S.of(context).genderMessage('male', 'KingWu')),
                  Text(S.of(context).genderMessage('female', 'KingWu')),
                  Text(S.of(context).genderMessage('other', 'KingWu')),
                  Text(S.of(context).specialCharactersMessage)
                ],
              )
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                switchLang();
              },
              child: Icon(Icons.add),
            )
          );
        },
      )

    );
  }

  void switchLang(){
    setState(() {
      index++;
      if(index >= localeList.length){
        index = 0;
      }
    });

  }
}
