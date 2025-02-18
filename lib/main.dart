import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/navigation_provider.dart';
import 'widgets/sidebar.dart';
import 'screens/dashboard_screen.dart';
import 'screens/scan_screen.dart';
import 'screens/collection_screen.dart';
import 'screens/settings_screen.dart';
import 'dart:async'; // Für `Future`

Future<void> main() async {
  // Stellt sicher, dass alle Flutter-Widgets und Plugins initialisiert sind
  WidgetsFlutterBinding.ensureInitialized();

  // Falls nötig: Lade API-Daten, Datenbank oder andere Services vor App-Start
  await Future.delayed(Duration(seconds: 2)); // Simulierte Initialisierung

  // Startet die App nach der Initialisierung
  runApp(
    ChangeNotifierProvider(
      create: (context) => NavigationProvider(),
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
      title: 'DeckDex App',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFe5e7de), // ✅ Hintergrundfarbe der gesamten App
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
        children: [
          Sidebar(), // 🟢 Sidebar bleibt immer sichtbar
          Expanded(child: screen),
        ],
      ),
    );
  }
}
