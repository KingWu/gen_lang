import 'package:flutter/material.dart';
import 'package:gen_lang_example/generated/i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
                  Text(S.of(context).messageOnly),
                  Text(S.of(context).messageHasParam('Yo')),
                  Text(S.of(context).pluralMsg(5)),
                  Text(S.of(context).pluralMsgWithParam(0, 'KingWu')),
                  Text(S.of(context).pluralMsgWithParam(1, 'KingWu')),
                  Text(S.of(context).pluralMsgWithParam(10, 'KingWu')),
                  Text(S.of(context).genderWithParam('male', 'KingWu')),
                  Text(S.of(context).genderWithParam('female', 'KingWu')),
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
