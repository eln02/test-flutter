import 'package:era_developers_test_flutter/presentation/ui/main_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ForestVPNTestApp());
}

class ForestVPNTestApp extends StatelessWidget {
  const ForestVPNTestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          textTheme: const TextTheme(
              headlineLarge: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  letterSpacing: 20 * 0.02,
                  fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.w500),
              displayLarge: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  letterSpacing: 28 * 0.02,
                  fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.w500),
              displayMedium: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  letterSpacing: 16 * 0.02,
                  fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.normal),
              displaySmall: TextStyle(
                  color: Color(0xFF9A9A9A),
                  fontSize: 12,
                  letterSpacing: 12 * 0.02,
                  fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.normal),
              labelMedium: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  letterSpacing: 18 * 0.02,
                  fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.normal)
          ),
        ),
        title: 'ForestVPN test',
        home: MainPage());
  }
}
