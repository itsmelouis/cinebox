import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Main navigation shell with bottom navigation bar
/// Uses the app's black/red theme
class MainNavigationShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainNavigationShell({
    required this.navigationShell,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          border: Border(
            top: BorderSide(
              color: Colors.grey.shade800,
              width: 0.5,
            ),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  context,
                  icon: Icons.home_outlined,
                  selectedIcon: Icons.home,
                  label: 'Accueil',
                  index: 0,
                ),
                _buildNavItem(
                  context,
                  icon: Icons.search_outlined,
                  selectedIcon: Icons.search,
                  label: 'Recherche',
                  index: 1,
                ),
                _buildNavItem(
                  context,
                  icon: Icons.bookmark_outline,
                  selectedIcon: Icons.bookmark,
                  label: 'Ma liste',
                  index: 2,
                ),
                _buildNavItem(
                  context,
                  icon: Icons.person_outline,
                  selectedIcon: Icons.person,
                  label: 'Profil',
                  index: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required IconData selectedIcon,
    required String label,
    required int index,
  }) {
    final isSelected = navigationShell.currentIndex == index;

    return InkWell(
      onTap: () {
        navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? selectedIcon : icon,
              color: isSelected ? Colors.red.shade600 : Colors.grey.shade600,
              size: 26,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.red.shade600 : Colors.grey.shade600,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
