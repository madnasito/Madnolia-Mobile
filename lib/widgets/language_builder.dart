// import 'package:flutter/material.dart';
// import 'package:multi_language_json/multi_language_json.dart';

// class LanguageBuilder extends StatelessWidget {
//   final Widget child;
//   LanguageBuilder({super.key, required this.child});
//   static late LangSupport langData;

//   @override
//   Widget build(BuildContext context) {

//     final locale = WidgetsFlutterBinding.ensureInitialized().window.locale;

//     MultiLanguageBloc language = MultiLanguageBloc(
//         initialLanguage: locale.languageCode,
//         defaultLanguage: locale.languageCode,
//         commonRoute: 'common',
//         supportedLanguages: ['en', 'es']);

//     return MultiLanguageStart(
//         future: language.init(),
//         builder: (context) => MultiStreamLanguage(builder: (context, data) {
//               langData = data;
//               return child;
//             }));
//   }
// }
