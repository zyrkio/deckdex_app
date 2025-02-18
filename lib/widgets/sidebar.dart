import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/navigation_provider.dart';
import '../theme/app_colors.dart';
import 'sidebar_item.dart';
import 'sidebar_toggle.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, provider, child) {
        final bool isCollapsed = provider.isCollapsed;
        final double sidebarWidth = isCollapsed ? 90 : 280;

        return Container(
          margin: const EdgeInsets.all(10),
          width: sidebarWidth,
          decoration: BoxDecoration(
            color: AppColors.sidebarBackground,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SidebarHeader(isCollapsed: isCollapsed),
              const SizedBox(height: 8),

              // 🔹 Navigationselemente
              SidebarItem(title: 'Dashboard', icon: Icons.dashboard, isCollapsed: isCollapsed),
              SidebarItem(title: 'Karten scannen', icon: Icons.camera_alt, isCollapsed: isCollapsed),
              SidebarItem(title: 'Sammlung', icon: Icons.collections, isCollapsed: isCollapsed),
              SidebarItem(title: 'Einstellungen', icon: Icons.settings, isCollapsed: isCollapsed),

              const Spacer(),
              SidebarToggleButton(isCollapsed: isCollapsed),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}

class SidebarHeader extends StatelessWidget {
  final bool isCollapsed;
  const SidebarHeader({required this.isCollapsed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo.jpg',
            width: 50,
            height: 50,
            fit: BoxFit.contain,
          ),
          if (!isCollapsed) const SizedBox(width: 12),
          if (!isCollapsed)
            const Text(
              'DeckDex',
              style: TextStyle(
                fontFamily: 'SwissDesign',
                fontSize: 24,
                color: AppColors.textDark,
                fontWeight: FontWeight.w900,
              ),
            ),
        ],
      ),
    );
  }
}
