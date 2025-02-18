import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/navigation_provider.dart';
import '../theme/app_colors.dart';

class SidebarToggleButton extends StatelessWidget {
  final bool isCollapsed;

  const SidebarToggleButton({required this.isCollapsed});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, provider, child) {
        final IconData icon = isCollapsed ? Icons.arrow_forward_ios : Icons.arrow_back_ios;

        return Padding(
          padding: EdgeInsets.only(right: isCollapsed ? 0 : 20),
          child: Align(
            alignment: isCollapsed ? Alignment.center : Alignment.centerRight,
            child: IconButton(
              icon: Icon(icon, color: AppColors.iconDefault, size: 32),
              onPressed: provider.toggleSidebar,
            ),
          ),
        );
      },
    );
  }
}
