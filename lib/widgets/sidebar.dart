import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/navigation_provider.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NavigationProvider>(context);
    final bool isCollapsed = provider.isCollapsed;
    final double sidebarWidth = isCollapsed ? 90 : 280; // ✅ Sidebar-Breite

    return Container(
      margin: EdgeInsets.all(12), // ✅ Abstand zum Fenster (Margin)
      width: sidebarWidth,
      decoration: BoxDecoration(
        color: Color(0xFFf1f2f0), // ✅ Hintergrundfarbe der Sidebar ändern
        borderRadius: BorderRadius.circular(20), // ✅ Runde Ecken (20px)
        boxShadow: [ // ✅ Schatten-Effekt
          BoxShadow(
            color: Color.fromARGB(255, 119, 121, 128), // ✅ Schattenfarbe mit Transparenz
            blurRadius: 10, // ✅ Weicher Schatten
            spreadRadius: 2, // ✅ Größe des Schattens
            offset: Offset(4, 4), // ✅ Positionierung (x, y)
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header mit Logo und Titel
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.jpg',
                  width: isCollapsed ? 50 : 65, 
                  height: isCollapsed ? 50 : 65, 
                  fit: BoxFit.contain,
                ),
                if (!isCollapsed)
                  SizedBox(width: 12),
                if (!isCollapsed)
                  SizedBox(
                    height: 50, // ✅ Feste Höhe setzen, um Layout-Springen zu verhindern
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'DeckDex',
                        style: TextStyle(
                          fontFamily: 'SwissDesign',
                          fontSize: 24,
                          color: Color(0xFF0f0a01), // ✅ Textfarbe ändern
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Navigations-Elemente
          _buildSidebarItem(context, provider, 'Dashboard', Icons.dashboard, isCollapsed),
          _buildSidebarItem(context, provider, 'Karten scannen', Icons.camera_alt, isCollapsed),
          _buildSidebarItem(context, provider, 'Sammlung', Icons.collections, isCollapsed),
          _buildSidebarItem(context, provider, 'Einstellungen', Icons.settings, isCollapsed),

          Spacer(), // Drückt die Icons nach oben

          // Toggle-Buttons (Back/Forward)
          _buildCollapseIcon(context, isCollapsed),

          SizedBox(height: 20), // ✅ Mehr Abstand nach unten
        ],
      ),
    );
  }

  Widget _buildSidebarItem(BuildContext context, NavigationProvider provider, String title, IconData icon, bool isCollapsed) {
    bool isSelected = provider.currentPage == title;

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: isCollapsed ? 0 : 20),
      title: Row(
        mainAxisAlignment: isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          Icon(
            icon, 
            color: isSelected ? Colors.orange : Color(0xFF0f0a01), // ✅ Icon-Farbe ändern
            size: isCollapsed ? 32 : 36, 
          ),
          if (!isCollapsed) 
            SizedBox(width: 16),
          if (!isCollapsed)
            Text(
              title,
              style: TextStyle(
                color: Color(0xFF2f292b), // ✅ Menü-Textfarbe ändern
                fontFamily: 'SwissDesign',
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
            ),
        ],
      ),
      tileColor: isSelected ? Colors.blueGrey[700] : null, // ✅ Hintergrundfarbe des ausgewählten Menüpunkts ändern
      onTap: () {
        provider.setPage(title);
      },
    );
  }

  Widget _buildCollapseIcon(BuildContext context, bool isCollapsed) {
    final provider = Provider.of<NavigationProvider>(context, listen: false);
    final double size = 60; 
    final IconData icon = isCollapsed ? Icons.arrow_forward_ios : Icons.arrow_back_ios;
    final Alignment alignment = isCollapsed ? Alignment.center : Alignment.centerRight;
    final double width = isCollapsed ? double.infinity : size;

    return Container(
      alignment: alignment, 
      padding: EdgeInsets.only(right: isCollapsed ? 0 : 20),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: Container(
            width: width,
            height: size,
            child: Icon(icon, color: Color(0xFF0f0a01), size: 32), // ✅ Farbe des Toggle-Pfeils ändern
          ),
          onTap: () {
            provider.toggleSidebar();
          },
        ),
      ),
    );
  }
}
