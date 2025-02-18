import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/navigation_provider.dart';
import '../theme/app_colors.dart';
class SidebarItem extends StatefulWidget {
  final String title;
  final IconData icon;
  final bool isCollapsed;

  const SidebarItem({
    required this.title,
    required this.icon,
    required this.isCollapsed,
  });

  @override
  _SidebarItemState createState() => _SidebarItemState();
}

class _SidebarItemState extends State<SidebarItem> {
  bool _isHovered = false; // 🔥 Hover-Status speichern

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, provider, child) {
        final bool isSelected = provider.currentPage == widget.title;

        return MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10), // 🔹 Abstand für Box-Look
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.selectedItem // 🔥 Wenn ausgewählt → Hauptfarbe
                  : _isHovered
                      ? Colors.grey[300] // 🔥 Hover-Farbe
                      : Colors.transparent, // Standard
              borderRadius: BorderRadius.circular(12), // 🔹 Runde Ecken
            ),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // 🔹 Ecken abrunden
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: widget.isCollapsed ? 0 : 20),
              leading: Container(
                width: widget.isCollapsed ? 50 : 40, // 🔹 Einheitliche Breite
                alignment: Alignment.center,
                child: Icon(
                  widget.icon,
                  color: isSelected ? Colors.white : AppColors.iconDefault,
                  size: 30,
                ),
              ),
              title: widget.isCollapsed
                  ? null
                  : Text(
                      widget.title,
                      style: TextStyle(
                        color: isSelected ? Colors.white : AppColors.textDark,
                        fontFamily: 'SwissDesign',
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
              onTap: () {
                try {
                  provider.setPage(widget.title);
                } catch (e) {
                  print('Navigation-Fehler: $e');
                }
              },
            ),
          ),
        );
      },
    );
  }
}
