import 'package:flutter/material.dart';
import '../widgets/sidebar.dart'; // Importiere die Sidebar

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _headline = "Dashboard"; // Standard-Überschrift

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Row(
        children: [
          Sidebar(onItemSelected: (String title) {
            setState(() {
              _headline = title; // Aktualisiert den Titel im Hauptbereich
            });
          }),
          Expanded(
            child: Center(
              child: Text(
                "Willkommen in $_headline!",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
