# gen_lang

gen_lang is a dart library for internationalization. Extracts messages
to generate dart files required by
[Intl](https://github.com/dart-lang/intl).

Now, three steps for internationalization

(1) Preparing Json files > (2) Run gen_lang > (3) Use it 

## Installation
Add these libraries into pubspec.yaml

``` 
dependencies: 
    flutter_localizations: 
        sdk: flutter 
dev_dependencies:
    gen_lang: 0.1.0
```
## Usage

```
pub run gen_Lang:generate
```

A below table shown all supported arguments:

| Argument  | Description |
|-----|-----|
| --source-dir | A source folder contains all string json files (defaults to "res/string") |
| --output-dir   | A output folder stores all generated files (defaults to "lib/generated") |
| --template-locale    |  Use string_{template-locale}.json as a template to search KEY. If string_en does not exist, this script will use the first string json file as a template (defaults to "en")   |

## Naming Convention for Json
Json files must be named in this pattern `string_{Locale}`

Example: string_en.json, string_ja.json and string_zh_TW.json

## Json Key & Message
### Simple message
Define a json key and message without parameters 

``` 
{ 
    "jsonKey": "Simple Message"
}
```

### Message with parameters

Define a message with parameters. Use ${parameterName} in a message.

```
{
    "jsonKey": "Hi ${yourName}, Welcome to use gen_lang"
}
```

### Plural messages with parameters 
Define messages in a plural form. ${how many} is a reserved parameter in
a plural message. This parameters support integer only. For Intl,
Intl.plural() supports these plural keyword including 'Zero', 'One',
'Two', 'Few', 'Many' and 'Other'. Define a json key into this pattern
{jsonKey} {pluralKeyword}. For 'Other', need to define 'POther' for the
pluarl keyword.

Example
```
{ 
    "jsonKeyZero": "Hi ${interviewerName}, I have no working experience.", 
    "jsonKeyOne": "Hi ${interviewerName}, I have one year of working experience.", 
    "jsonKeyTwo": "Hi ${interviewerName}, I have two years of working experience.", 
    "jsonKeyFew": "Hi ${interviewerName}, I have few years of working experience.", 
    "jsonKeyMany": "Hi ${interviewerName}, I worked for a long time.", 
    "jsonKeyPOther": "Hi ${interviewerName}, I have ${howMany} years of working experience."
}
``` 
 
To know plural rules more, please read
[Intl's plural rules](https://github.com/dart-lang/intl/blob/master/lib/src/plural_rules.dart)
source code.

### Gender message with parameters
Define a message in gender form. ${targetGender} is a reserved parameter
in a gender message. This parameters support string value with 'male',
female' and 'other'. For Intl, Intl.gender() supports these keyword
including 'Male', 'Female' and 'Other'. Define a json key into this
pattern {jsonKey} {genderKeyword}. For 'Other', need to define 'GOther'
for the gender keyword.

Example
```
{ 
    "jsonKeyMale": "Hi ${name}, He is boy.", 
    "jsonKeyFemale": "Hi ${name}, She is girl", 
    "jsonKeyGOther": "Hi ${name}, he/she is boy/girl." 
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

S.of(context).jsonKey; // Simple Message 
S.of(context).jsonKey(name); // Message with parameters
S.of(context).jsonKey(10, 'King Wu'); // Plural Message with parameters
S.of(context).jsonKey('male', 'King Wu'); // Gender Message with parameters
```

### Running Script in Example
Go into example folder. Run the command - pub run gen_Lang:generate

Then will generate `i18n.dart` and `messages_all.dart`