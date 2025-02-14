import 'package:flutter/material.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';

class Sidebar extends StatefulWidget {
  final Function(String) onItemSelected; // Funktion zum Aktualisieren des Titels

  const Sidebar({super.key, required this.onItemSelected});

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  late List<CollapsibleItem> _items;
  late bool _isCollapsed;

  @override
  void initState() {
    super.initState();
    _isCollapsed = true;
    _items = _generateItems();
  }

  List<CollapsibleItem> _generateItems() {
    return [
      CollapsibleItem(
        text: 'Dashboard',
        icon: Icons.dashboard,
        onPressed: () => widget.onItemSelected('Dashboard'),
        isSelected: true,
      ),
      CollapsibleItem(
        text: 'Karten scannen',
        icon: Icons.camera_alt,
        onPressed: () => widget.onItemSelected('Karten scannen'),
      ),
      CollapsibleItem(
        text: 'Sammlung',
        icon: Icons.collections,
        onPressed: () => widget.onItemSelected('Sammlung'),
      ),
      CollapsibleItem(
        text: 'Einstellungen',
        icon: Icons.settings,
        onPressed: () => widget.onItemSelected('Einstellungen'),
        
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CollapsibleSidebar(
      items: _items,
      avatarImg: const NetworkImage("https://www.w3schools.com/howto/img_avatar.png"),
      title: "MTG App",
      backgroundColor: const Color(0xFFf1f2f0), // Hellgrau für Hintergrund
      selectedTextColor: const Color(0xFFf1f2f0), // Weiß für aktiven Text
      unselectedTextColor: Color(0xFF666666),
      unselectedIconColor: Color(0xFF666666),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontFamily: 'SwissDesign', // Eigene Schriftart aus `pubspec.yaml`
        color: Color(0xFF000000), // 🟢 Hier Schwarz setzen
      ),
      titleStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'SwissDesign', // Gleiche Schrift für Titel
        color: Color(0xFF263238), // Dunkler für bessere Lesbarkeit
      ),
      toggleTitle: "Menü",
      sidebarBoxShadow: const [
        BoxShadow(
          color: Color(0xFFdfe0e2), // ✅ Dunkler Schatten
          blurRadius: 8,           // ✅ Weicher Schatten
        ),
      ],
      isCollapsed: _isCollapsed,
      onTitleTap: () => setState(() => _isCollapsed = !_isCollapsed),
      body: Container(), // Muss existieren, aber wird nicht verwendet
    );
  }

}
