import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  bool _isCollapsed = false;
  String _currentPage = 'Dashboard'; // Standardseite

  // Getter für den Zustand
  bool get isCollapsed => _isCollapsed;
  String get currentPage => _currentPage;

  // Umschalten zwischen kompletter Sidebar und Icon-Ansicht
  void toggleSidebar() {
    _isCollapsed = !_isCollapsed;
    notifyListeners();
  }

  // Ändert die aktuell gewählte Seite
  void setPage(String page) {
    _currentPage = page;
    notifyListeners();
  }
}
