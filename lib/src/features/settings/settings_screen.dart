import 'package:flutter/material.dart';
import 'package:omniconnect_crm/src/core/theme/app_theme.dart';
import 'package:omniconnect_crm/src/core/utils/responsive_helper.dart';
import 'package:omniconnect_crm/src/shared/widgets/app_scaffold.dart';
import 'package:omniconnect_crm/src/shared/widgets/common_widgets.dart';
import 'package:omniconnect_crm/src/shared/widgets/navigation.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _currentNavIndex = 6;
  int _selectedSection = 0;

  bool _notificationsEnabled = true;
  bool _emailNotifications = true;
  bool _pushNotifications = true;
  bool _darkMode = false;
  bool _twoFactorAuth = false;

  final List<Map<String, dynamic>> _settingsSections = [
    {
      'title': 'Account',
      'icon': Icons.person_outline,
      'items': [
        {'title': 'Profile', 'subtitle': 'Manage your account details'},
        {'title': 'Security', 'subtitle': 'Password and authentication'},
        {'title': 'Billing', 'subtitle': 'Subscription and payments'},
      ],
    },
    {
      'title': 'Preferences',
      'icon': Icons.settings_outlined,
      'items': [
        {'title': 'Notifications', 'subtitle': 'Configure notification preferences'},
        {'title': 'Appearance', 'subtitle': 'Theme and display settings'},
        {'title': 'Language', 'subtitle': 'Change app language'},
      ],
    },
    {
      'title': 'Integrations',
      'icon': Icons.extension_outlined,
      'items': [
        {'title': 'Connected Apps', 'subtitle': 'Manage third-party integrations'},
        {'title': 'API Keys', 'subtitle': 'Manage API access'},
        {'title': 'Webhooks', 'subtitle': 'Configure webhook endpoints'},
      ],
    },
    {
      'title': 'Team',
      'icon': Icons.group_outline,
      'items': [
        {'title': 'Members', 'subtitle': 'Manage team members'},
        {'title': 'Roles', 'subtitle': 'Configure access permissions'},
        {'title': 'Activity Log', 'subtitle': 'View team activity'},
      ],
    },
  ];

  final List<Map<String, dynamic>> _teamMembers = [
    {
      'name': 'Yudi Hariyanto',
      'email': 'yudihariyanto41@gmail.com',
      'role': 'Owner',
      'avatar': 'YU',
    },
    {
      'name': 'Sarah Johnson',
      'email': 'sarah@example.com',
      'role': 'Admin',
      'avatar': 'SJ',
    },
    {
      'name': 'Mike Chen',
      'email': 'mike@example.com',
      'role': 'Agent',
      'avatar': 'MC',
    },
  ];

  final List<Map<String, dynamic>> _connectedApps = [
    {
      'name': 'Shopify',
      'icon': Icons.shopping_bag,
      'connected': true,
    },
    {
      'name': 'Google Sheets',
      'icon': Icons.table_chart,
      'connected': false,
    },
    {
      'name': 'Zapier',
      'icon': Icons.auto_awesome,
      'connected': true,
    },
    {
      'name': 'Slack',
      'icon': Icons.chat_bubble_outline,
      'connected': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);

    return AppScaffold(
      drawer: isDesktop ? null : const Drawer(),
      body: Row(
        children: [
          if (isDesktop)
            SizedBox(
              width: ResponsiveHelper.getSidebarWidth(context),
              child: MainNavigation(
                currentIndex: _currentNavIndex,
                onIndexChanged: (index) => setState(() => _currentNavIndex = index),
              ),
            ),
          Expanded(
            child: _buildContent(context),
          ),
        ],
      ),
      bottomNavigationBar: isDesktop ? null : MainNavigation(
        currentIndex: _currentNavIndex,
        onIndexChanged: (index) => setState(() => _currentNavIndex = index),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);

    return Row(
      children: [
        if (isDesktop)
          _buildSettingsNav(context),
        Expanded(
          child: _buildSettingsContent(context),
        ),
      ],
    );
  }

  Widget _buildSettingsNav(BuildContext context) {
    return Container(
      width: 280,
      color: AppTheme.surface,
      child: ListView.builder(
        itemCount: _settingsSections.length,
        itemBuilder: (context, index) {
          final section = _settingsSections[index];
          final isSelected = _selectedSection == index;

          return Column(
            children: [
              InkWell(
                onTap: () => setState(() => _selectedSection = index),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Icon(
                        section['icon'] as IconData,
                        color: isSelected ? AppTheme.primary : AppTheme.textSecondary,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        section['title'] as String,
                        style: TextStyle(
                          color: isSelected ? AppTheme.primary : AppTheme.textPrimary,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (isSelected)
                ...(section['items'] as List).map((item) {
                  return InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(left: 48, top: 8, bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title'] as String,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            item['subtitle'] as String,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              const Divider(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSettingsContent(BuildContext context) {
    switch (_selectedSection) {
      case 0:
        return _buildAccountSection(context);
      case 1:
        return _buildPreferencesSection(context);
      case 2:
        return _buildIntegrationsSection(context);
      case 3:
        return _buildTeamSection(context);
      default:
        return _buildAccountSection(context);
    }
  }

  Widget _buildAccountSection(BuildContext context) {
    return AdaptiveContainer(
      child: SingleChildScrollView(
        padding: ResponsiveHelper.getScreenPadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Account Settings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 24),
            _buildProfileCard(),
            const SizedBox(height: 24),
            _buildSecurityCard(),
            const SizedBox(height: 24),
            _buildBillingCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Profile',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Avatar(
                initials: 'YU',
                size: 64,
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Yudi Hariyanto',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'yudihariyanto41@gmail.com',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          PrimaryButton(
            text: 'Edit Profile',
            onPressed: () {},
            isFullWidth: false,
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Security',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          _buildSettingsRow(
            'Two-Factor Authentication',
            'Add an extra layer of security',
            Switch(
              value: _twoFactorAuth,
              onChanged: (value) => setState(() => _twoFactorAuth = value),
            ),
          ),
          const Divider(height: 24),
          _buildSettingsRow(
            'Change Password',
            'Update your password regularly',
            const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(height: 24),
          _buildSettingsRow(
            'Active Sessions',
            'Manage your active sessions',
            const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildBillingCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Billing',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.star,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Free Plan',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Up to 100 contacts, basic features',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Upgrade'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesSection(BuildContext context) {
    return AdaptiveContainer(
      child: SingleChildScrollView(
        padding: ResponsiveHelper.getScreenPadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Preferences',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 24),
            _buildNotificationsCard(),
            const SizedBox(height: 24),
            _buildAppearanceCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Notifications',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          _buildSettingsRow(
            'Push Notifications',
            'Receive push notifications',
            Switch(
              value: _pushNotifications,
              onChanged: (value) => setState(() => _pushNotifications = value),
            ),
          ),
          const Divider(height: 16),
          _buildSettingsRow(
            'Email Notifications',
            'Receive email notifications',
            Switch(
              value: _emailNotifications,
              onChanged: (value) => setState(() => _emailNotifications = value),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppearanceCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Appearance',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          _buildSettingsRow(
            'Dark Mode',
            'Use dark theme',
            Switch(
              value: _darkMode,
              onChanged: (value) => setState(() => _darkMode = value),
            ),
          ),
          const Divider(height: 16),
          _buildSettingsRow(
            'Language',
            'English (US)',
            const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildIntegrationsSection(BuildContext context) {
    return AdaptiveContainer(
      child: SingleChildScrollView(
        padding: ResponsiveHelper.getScreenPadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Integrations',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 24),
            _buildConnectedAppsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildConnectedAppsList() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Connected Apps',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text('Add New'),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          ..._connectedApps.map((app) => ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: (app['connected'] as bool)
                        ? AppTheme.primary.withOpacity(0.1)
                        : AppTheme.textMuted.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    app['icon'] as IconData,
                    color: (app['connected'] as bool)
                        ? AppTheme.primary
                        : AppTheme.textMuted,
                  ),
                ),
                title: Text(app['name'] as String),
                subtitle: Text(
                  (app['connected'] as bool) ? 'Connected' : 'Not connected',
                ),
                trailing: (app['connected'] as bool)
                    ? OutlinedButton(
                        onPressed: () {},
                        child: const Text('Disconnect'),
                      )
                    : ElevatedButton(
                        onPressed: () {},
                        child: const Text('Connect'),
                      ),
              )),
        ],
      ),
    );
  }

  Widget _buildTeamSection(BuildContext context) {
    return AdaptiveContainer(
      child: SingleChildScrollView(
        padding: ResponsiveHelper.getScreenPadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Team Members',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                PrimaryButton(
                  text: 'Invite Member',
                  onPressed: () {},
                  isFullWidth: false,
                  icon: const Icon(Icons.person_add, size: 18),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildTeamMembersList(),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamMembersList() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        children: _teamMembers.map((member) {
          return ListTile(
            leading: Avatar(
              initials: member['avatar'] as String,
              size: 40,
            ),
            title: Text(member['name'] as String),
            subtitle: Text(member['email'] as String),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    member['role'] as String,
                    style: TextStyle(
                      color: AppTheme.primary,
                      fontSize: 12,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSettingsRow(
    String title,
    String subtitle,
    Widget trailing, {
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}
