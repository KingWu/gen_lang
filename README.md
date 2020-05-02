# gen_lang

gen_lang is a dart library for internationalization. Extracts messages
to generate dart files required by
[Intl](https://github.com/dart-lang/intl).

Now, three steps for internationalization

1. Preparing Json files 
2. Run gen_lang 
3. Use it in coding

## Installation
Add these libraries into `pubspec.yaml`

``` 
dependencies: 
    flutter_localizations: 
        sdk: flutter 
dev_dependencies:
    gen_lang: 0.1.3
```
## Usage

```
pub run gen_lang:generate
```

A below table shown all supported arguments:

| Argument  | Description |
|-----|-----|
| --source-dir | A source folder contains all string json files (defaults to "res/string") |
| --output-dir   | A output folder stores all generated files (defaults to "lib/generated") |
| --template-locale    |  Use string_{template-locale}.json as a template to search KEY. If string_en does not exist, this script will use the first string json file as a template (defaults to "en")   |

## Source of Json Files
By default, the json files are required to locate at `res/string`. Using
`--source-dir` argument can change the default source path. These files
must be named in this pattern `string_{Locale}.json`

Example of the files,

```
|--- lib 
|--- res 
     |--- string 
         |--- string_en.json 
         |--- string_zh_TW.json 
         |--- string_ja.json 
```

## Supported Message Type
### Simple message
Define a json key and message without parameters 

``` 
{ 
    "simpleMessage": "This is a simple Message"
}
```

### Message with parameters

Define a message with parameters. Use ${parameterName} in a message.

```
{
    "messageWithParams": "Hi ${yourName}, Welcome you!"
}
```

### Plural messages with parameters 
Define messages in a plural form. ${how many} is a reserved parameter in
a plural message. This parameters support integer only. For Intl,
[Intl.plural()](https://api.flutter.dev/flutter/intl/Intl/plural.html) supports these plural keyword including 'Zero', 'One',
'Two', 'Few', 'Many' and 'Other'. Define a json key into this pattern
{jsonKey} {pluralKeyword}. For 'Other', need to define 'POther' for the
plural keyword.

Example
```
{ 
    "pluralMessageZero": "Hi ${interviewerName}, I have no working experience.", 
    "pluralMessageOne": "Hi ${interviewerName}, I have one year working experience.", 
    "pluralMessageTwo": "Hi ${interviewerName}, I have two years of working experience.", 
    "pluralMessageFew": "Hi ${interviewerName}, I have few years of working experience.", 
    "pluralMessageMany": "Hi ${interviewerName}, I worked for a long time.", 
    "pluralMessagePOther": "Hi ${interviewerName}, I have ${howMany} years of working experience."
}
``` 
 
To know plural rules more, please read
[Intl's plural rules](https://github.com/dart-lang/intl/blob/master/lib/src/plural_rules.dart)
source code.

### Gender message with parameters
Define a message in gender form. ${targetGender} is a reserved parameter
in a gender message. This parameters support string value with 'male',
female' and 'other'. For Intl, [Intl.gender()](https://api.flutter.dev/flutter/intl/Intl/gender.html) supports these keyword
including 'Male', 'Female' and 'Other'. Define a json key into this
pattern {jsonKey} {genderKeyword}. For 'Other', need to define 'GOther'
for the gender keyword.

Example
```
{ 
    "genderMessageMale": "Hi ${name}, He is boy.", 
    "genderMessageFemale": "Hi ${name}, She is girl", 
    "genderMessageGOther": "Hi ${name}, he/she is boy/girl." 
}
```  
 

## Usage of i18n.dart 
The script will generate two files into the output folder including
`i18n.dart` and `messages_all.dart`. Import `i18n.dart` into your source
code. Then finish internationalization tasks.

Example 
``` 
import 'package:gen_lang_example/generated/i18n.dart';

...

MaterialApp(
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      
      ...
      ...

        S.of(context).simpleMessage; // Simple Message 
        S.of(context).messageWithParams('developer'); // Message with parameters
        S.of(context).pluralMessage(10, 'King Wu'); // Plural Message with parameters
        S.of(context).genderMessage('male', 'King Wu'); // Gender Message with parameters
```

### Running Script in Example

Go into example folder. Run the command

``` 
cd example
pub run gen_lang:generate
```

Then will generate `i18n.dart` and `messages_all.dart`