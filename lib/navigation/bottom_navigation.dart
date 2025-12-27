import 'package:flutter/material.dart';
import 'package:uimspace_app/core/theme/space_theme.dart';
import 'package:uimspace_app/features/home/presentation/home_page.dart';
import 'package:uimspace_app/features/courses/presentation/my_courses_page.dart';
import 'package:uimspace_app/features/profile/presentation/profile_page.dart';

/// Item untuk Bottom Navigation
class NavItem {
  final String label;
  final IconData icon;
  final IconData activeIcon;

  const NavItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
  });
}

/// Main Shell dengan Bottom Navigation
/// Mengatur navigasi utama aplikasi: Beranda, Kelas Saya, Profil
class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key});

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _currentIndex = 0;

  // Daftar halaman
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(onTabChangeRequested: _onNavItemTapped),
      const MyCoursesPage(),
      const ProfilePage(),
    ];
  }

  // Daftar item navigasi
  final List<NavItem> _navItems = const [
    NavItem(
      label: 'Beranda',
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
    ),
    NavItem(
      label: 'Kelas Saya',
      icon: Icons.school_outlined,
      activeIcon: Icons.school,
    ),
    NavItem(
      label: 'Profil',
      icon: Icons.person_outline,
      activeIcon: Icons.person,
    ),
  ];

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  /// Build Bottom Navigation Bar dengan style Space Learning
  Widget _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        color: SpaceColors.surface,
        border: const Border(
          top: BorderSide(color: SpaceColors.border, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: SpaceColors.shadow.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SpaceDimensions.spacing8,
            vertical: SpaceDimensions.spacing4,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              _navItems.length,
              (index) => _buildNavItem(index),
            ),
          ),
        ),
      ),
    );
  }

  /// Build individual nav item
  Widget _buildNavItem(int index) {
    final item = _navItems[index];
    final isSelected = _currentIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () => _onNavItemTapped(index),
        borderRadius: BorderRadius.circular(SpaceDimensions.radiusMd),
        child: AnimatedContainer(
          duration: SpaceDimensions.durationFast,
          curve: SpaceDimensions.curveDefault,
          padding: const EdgeInsets.symmetric(
            vertical: SpaceDimensions.spacing8,
          ),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(SpaceDimensions.radiusMd),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon with animation
              AnimatedSwitcher(
                duration: SpaceDimensions.durationFast,
                child: Icon(
                  isSelected ? item.activeIcon : item.icon,
                  key: ValueKey(isSelected),
                  size: SpaceDimensions.iconLg,
                  color: isSelected
                      ? SpaceColors.primary
                      : SpaceColors.textSecondary,
                ),
              ),
              const SizedBox(height: SpaceDimensions.spacing2),
              // Label
              Text(
                item.label,
                style: SpaceTextStyles.labelSmall.copyWith(
                  color: isSelected
                      ? SpaceColors.primary
                      : SpaceColors.textSecondary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
