import 'package:currency_app/di.dart';
import 'package:currency_app/ui/main/main_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUp();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale("uz", "UZ"),
        Locale("en", "EN"),
        Locale("ru", "RU"),
        Locale("uz", "UZC"),
      ],
      path: 'assets/tr',
      startLocale: const Locale('uz', 'UZ'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const MainScreen().page,
    );
  }
}
