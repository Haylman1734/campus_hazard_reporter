import 'package:flutter/material.dart';
import 'data.dart';
import 'onboarding_screen.dart';
// flutter run -d edge
// cd campus_hazard_reporter

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Hazard Reporter',
      debugShowCheckedModeBanner: false,

      // ThemeData is defined only once here and used by every screen
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: mainColor),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: mainColor,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: mainColor,
            foregroundColor: Colors.white,
            minimumSize: Size(double.infinity, 50),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),

      home: OnboardingScreen(),
    );
  }
}
