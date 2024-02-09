import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';
import 'package:love_propose/router.dart';
import 'package:love_propose/style/theme.dart';

ThemeData? light;
ThemeData? dark;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeStr = await rootBundle.loadString('image/light_theme.json');
  final darkStr = await rootBundle.loadString('image/dark_theme.json');
  final themeJson = jsonDecode(themeStr);
  final darkJson = jsonDecode(darkStr);
  light = ThemeDecoder.decodeThemeData(themeJson)!;
  dark = ThemeDecoder.decodeThemeData(darkJson)!;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Do you love me!',
      themeMode: ThemeMode.system,
      theme: light,
      darkTheme: dark,
      routerConfig: AppRoots().router,
      debugShowCheckedModeBanner: false,
    );
  }
}
