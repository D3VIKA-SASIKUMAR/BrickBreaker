import 'package:brickbreakdown/theme/colorscheme.dart';
import 'package:brickbreakdown/view/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: lightGameColorScheme, useMaterial3: true),
      darkTheme: ThemeData(
        colorScheme: darkGameColorScheme,
        useMaterial3: true,
      ),
      themeMode: ThemeMode.dark,
      home: HomePage(),
    );
  }
}
