import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart'; // Import des Dashboard-Screens

void main() {
  runApp(const MyApp(title: "MTG App"));
}

class MyApp extends StatelessWidget {
  final String title;

  // Konstruktor mit `required` für Pflichtparameter
  const MyApp({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title, // Hier wird der Wert verwendet
      home: DashboardScreen(),
      debugShowCheckedModeBanner: false
    );
  }
}

