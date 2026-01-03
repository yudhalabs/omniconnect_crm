import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omniconnect_crm/src/core/theme/app_theme.dart';
import 'package:omniconnect_crm/src/core/utils/responsive_helper.dart';

class MainNavigation extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onIndexChanged;
  final bool showLabels;
  final bool isCollapsed;

  const MainNavigation({
    super.key,
    required this.currentIndex,
    required this.onIndexChanged,
    this.showLabels = true,
    this.isCollapsed = false,
  });

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  final List<NavItem> _navItems = [
    NavItem(
      label: 'Dashboard',
      icon: 'dashboard',
      route: '/dashboard',
    ),
    NavItem(
      label: 'Inbox',
      icon: 'inbox',
      route: '/inbox',
      badge: true,
    ),
    NavItem(
      label: 'Contacts',
      icon: 'contacts',
      route: '/contacts',
    ),
    NavItem(
      label: 'Broadcast',
      icon: 'broadcast',
      route: '/broadcast',
    ),
    NavItem(
      label: 'Channels',
      icon: 'channels',
      route: '/channels',
    ),
    NavItem(
      label: 'Reports',
      icon: 'reports',
      route: '/reports',
    ),
    NavItem(
      label: 'Settings',
      icon: 'settings',
      route: '/settings',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);

    if (isDesktop) {
      return _buildDesktopNav();
    }

    return _buildMobileNav();
  }

  Widget _buildDesktopNav() {
    return Container(
      width: widget.isCollapsed ? 80 : 280,
      decoration: BoxDecoration(
        color: AppTheme.surface,
        border: Border(
          right: BorderSide(color: AppTheme.border.withOpacity(0.5)),
        ),
      ),
      child: Column(
        children: [
          _buildLogo(),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _navItems.length,
              itemBuilder: (context, index) =>
                  _buildNavItem(_navItems[index], index),
            ),
          ),
          _buildUserProfile(),
        ],
      ),
    );
  }

  Widget _buildMobileNav() {
    return NavigationBar(
      selectedIndex: widget.currentIndex,
      onDestinationSelected: widget.onIndexChanged,
      destinations: _navItems.map((item) {
        return NavigationDestination(
          icon: Badge(
            label: const Text('!'),
            child: SvgPicture.asset(
              'assets/images/${item.icon}.svg',
              width: 24,
              height: 24,
              color: AppTheme.textSecondary,
            ),
          ),
          label: item.label,
        );
      }).toList(),
    );
  }

  Widget _buildLogo() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.chat_bubble_outline,
              color: AppTheme.white,
            ),
          ),
          if (!widget.isCollapsed) ...[
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'OmniConnect',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNavItem(NavItem item, int index) {
    final isSelected = widget.currentIndex == index;

    return Tooltip(
      message: item.label,
      child: InkWell(
        onTap: () => widget.onIndexChanged(index),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? AppTheme.primary.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/images/${item.icon}.svg',
                width: 24,
                height: 24,
                color: isSelected ? AppTheme.primary : AppTheme.textSecondary,
              ),
              if (!widget.isCollapsed) ...[
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item.label,
                    style: TextStyle(
                      color: isSelected ? AppTheme.primary : AppTheme.textPrimary,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ),
                if (item.badge)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppTheme.error,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      '3',
                      style: TextStyle(
                        color: AppTheme.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserProfile() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppTheme.border.withOpacity(0.5)),
        ),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundColor: AppTheme.primary,
            child: Text(
              'YU',
              style: TextStyle(
                color: AppTheme.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (!widget.isCollapsed) ...[
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Yudi Hariyanto',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'Business Owner',
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class NavItem {
  final String label;
  final String icon;
  final String route;
  final bool badge;

  const NavItem({
    required this.label,
    required this.icon,
    required this.route,
    this.badge = false,
  });
}

/// Sidebar Item for sub-navigation
class SidebarItem extends StatelessWidget {
  final String title;
  final String icon;
  final bool isSelected;
  final VoidCallback onTap;
  final List<SidebarItem>? children;
  final bool isExpanded;

  const SidebarItem({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    this.children,
    this.isExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(
                  isSelected ? Icons.folder : Icons.folder_outlined,
                  size: 20,
                  color: isSelected ? AppTheme.primary : AppTheme.textSecondary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: isSelected ? AppTheme.primary : AppTheme.textPrimary,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ),
                if (children != null)
                  Icon(
                    isExpanded
                        ? Icons.expand_less
                        : Icons.expand_more,
                    color: AppTheme.textSecondary,
                  ),
              ],
            ),
          ),
        ),
        if (children != null && isExpanded)
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              children: children!
                  .map((child) => Padding(
                        padding: const EdgeInsets.only(left: 32),
                        child: SidebarItem(
                          title: child.title,
                          icon: child.icon,
                          isSelected: child.isSelected,
                          onTap: child.onTap,
                        ),
                      ))
                  .toList(),
            ),
          ),
      ],
    );
  }
}
