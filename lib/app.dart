import 'package:flutter/material.dart';

import 'views/screens/calorie_home_screen.dart';

class CalorieTrackerApp extends StatelessWidget {
  const CalorieTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    const forest = Color(0xFF1F6B4E);
    const canvas = Color(0xFFF6F8F5);

    return MaterialApp(
      title: 'Calorie Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: canvas,
        colorScheme: ColorScheme.fromSeed(seedColor: forest, surface: canvas),
        appBarTheme: const AppBarTheme(
          backgroundColor: canvas,
          foregroundColor: Color(0xFF17231C),
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      home: const CalorieHomeScreen(),
    );
  }
}
