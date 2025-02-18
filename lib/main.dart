import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart'; // ✅ Fenstergröße kontrollieren
import 'providers/navigation_provider.dart';
import 'widgets/sidebar.dart';
import 'screens/dashboard_screen.dart';
import 'screens/scan_screen.dart';
import 'screens/collection_screen.dart';
import 'screens/settings_screen.dart';
import 'dart:async';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (context) => NavigationProvider(),
      child: const MyApp(),
    ),
  );

  // 🟢 Hier die Fenstergröße auf 1024x600 fixieren
  doWhenWindowReady(() {
    final win = appWindow;
    win.minSize = Size(1024, 600);
    win.maxSize = Size(1024, 600);
    win.size = Size(1024, 600);
    win.alignment = Alignment.center;
    win.show();
  });
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeckDex App',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFfbfbfb), // ✅ Hintergrundfarbe der gesamten App
      ), // 🎨 Dunkles Design für Ubuntu
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NavigationProvider>(context);

    Widget screen;
    switch (provider.currentPage) {
      case 'Karten scannen':
        screen = ScanScreen();
        break;
      case 'Sammlung':
        screen = CollectionScreen();
        break;
      case 'Einstellungen':
        screen = SettingsScreen();
        break;
      default:
        screen = DashboardScreen();
    }

    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Damit beide oben ausgerichtet sind
        children: [
          Sidebar(), // Sidebar bleibt fix

         

          Expanded(
            child: Container(
              margin: EdgeInsets.all(10), // 👉 Außenabstand für den Content-Bereich
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255), // Hintergrundfarbe des Hauptinhalts
                borderRadius: BorderRadius.circular(12), // Abgerundete Ecken
                
              ),
              child: screen, // Zeigt die aktuelle Seite (Dashboard, Scan, etc.)
            ),
          ),
        ],
      ),
    );
  }
}
