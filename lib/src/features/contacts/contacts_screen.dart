import 'package:flutter/material.dart';
import 'package:omniconnect_crm/src/core/theme/app_theme.dart';
import 'package:omniconnect_crm/src/core/utils/responsive_helper.dart';
import 'package:omniconnect_crm/src/shared/widgets/app_scaffold.dart';
import 'package:omniconnect_crm/src/shared/widgets/common_widgets.dart';
import 'package:omniconnect_crm/src/shared/widgets/navigation.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  int _currentNavIndex = 2;
  int _selectedSegment = 0;
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _contacts = [
    {
      'id': '1',
      'name': 'John Doe',
      'email': 'john@example.com',
      'phone': '+6281234567890',
      'avatar': 'JD',
      'tags': ['VIP', 'Customer'],
      'lastContact': '2 hours ago',
      'totalConversations': 15,
      'status': 'active',
    },
    {
      'id': '2',
      'name': 'Jane Smith',
      'email': 'jane@example.com',
      'phone': '+6282345678901',
      'avatar': 'JS',
      'tags': ['New Lead'],
      'lastContact': '1 day ago',
      'totalConversations': 3,
      'status': 'new',
    },
    {
      'id': '3',
      'name': 'Bob Johnson',
      'email': 'bob@example.com',
      'phone': '+6283456789012',
      'avatar': 'BJ',
      'tags': ['Customer', 'Returning'],
      'lastContact': '3 days ago',
      'totalConversations': 42,
      'status': 'active',
    },
    {
      'id': '4',
      'name': 'Alice Brown',
      'email': 'alice@example.com',
      'phone': '+6284567890123',
      'avatar': 'AB',
      'tags': ['Prospect'],
      'lastContact': '1 week ago',
      'totalConversations': 5,
      'status': 'inactive',
    },
    {
      'id': '5',
      'name': 'Charlie Wilson',
      'email': 'charlie@example.com',
      'phone': '+6285678901234',
      'avatar': 'CW',
      'tags': ['VIP', 'Premium'],
      'lastContact': '30 minutes ago',
      'totalConversations': 89,
      'status': 'active',
    },
  ];

  final List<Map<String, dynamic>> _tags = [
    {'name': 'All', 'count': 156},
    {'name': 'VIP', 'count': 23},
    {'name': 'Customer', 'count': 89},
    {'name': 'Lead', 'count': 31},
    {'name': 'Prospect', 'count': 13},
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
    return AdaptiveContainer(
      child: SingleChildScrollView(
        padding: ResponsiveHelper.getScreenPadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildStatsRow(),
            const SizedBox(height: 20),
            _buildContactsSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contacts',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Manage your customer database',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
        Row(
          children: [
            SecondaryButton(
              text: 'Import',
              onPressed: () {},
              icon: const Icon(Icons.upload_outlined, size: 18),
            ),
            const SizedBox(width: 12),
            PrimaryButton(
              text: 'Add Contact',
              onPressed: () {},
              icon: const Icon(Icons.add, size: 18),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        _buildStatCard(
          'Total Contacts',
          '156',
          Icons.people_outline,
          AppTheme.primary,
        ),
        const SizedBox(width: 16),
        _buildStatCard(
          'Active Customers',
          '89',
          Icons.trending_up,
          AppTheme.success,
        ),
        const SizedBox(width: 16),
        _buildStatCard(
          'New Leads',
          '31',
          Icons.person_add,
          AppTheme.secondary,
        ),
        const SizedBox(width: 16),
        _buildStatCard(
          'VIP Customers',
          '23',
          Icons.star,
          AppTheme.accent,
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.border),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactsSection(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        children: [
          _buildSectionHeader(),
          const Divider(height: 1),
          _buildTagsRow(),
          const Divider(height: 1),
          _buildContactsTable(context),
        ],
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: SearchBar(
              controller: _searchController,
              hintText: 'Search contacts...',
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_list_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }

  Widget _buildTagsRow() {
    return SizedBox(
      height: 48,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _tags.length,
        itemBuilder: (context, index) {
          final tag = _tags[index];
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text('${tag['name']} (${tag['count']})'),
              selected: _selectedSegment == index,
              onSelected: (selected) {
                setState(() => _selectedSegment = index);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildContactsTable(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);

    if (isDesktop) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: double.infinity,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Contact')),
              DataColumn(label: Text('Phone')),
              DataColumn(label: Text('Tags')),
              DataColumn(label: Text('Last Contact')),
              DataColumn(label: Text('Conversations')),
              DataColumn(label: Text('Actions')),
            ],
            rows: _contacts.map((contact) {
              return DataRow(
                cells: [
                  DataCell(
                    Row(
                      children: [
                        Avatar(
                          initials: contact['avatar'] as String,
                          size: 36,
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              contact['name'] as String,
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              contact['email'] as String,
                              style: TextStyle(
                                fontSize: 12,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  DataCell(Text(contact['phone'] as String)),
                  DataCell(
                    Wrap(
                      spacing: 4,
                      children: (contact['tags'] as List)
                          .map((tag) => _buildTagChip(tag as String))
                          .toList(),
                    ),
                  ),
                  DataCell(Text(contact['lastContact'] as String)),
                  DataCell(
                    Text('${contact['totalConversations']}'),
                  ),
                  DataCell(
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.message_outlined, size: 18),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.edit_outlined, size: 18),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      );
    }

    // Mobile view - list
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _contacts.length,
      itemBuilder: (context, index) =>
          _buildContactItem(_contacts[index]),
    );
  }

  Widget _buildTagChip(String tag) {
    Color tagColor;
    switch (tag) {
      case 'VIP':
        tagColor = AppTheme.accent;
        break;
      case 'Customer':
        tagColor = AppTheme.primary;
        break;
      case 'Lead':
        tagColor = AppTheme.secondary;
        break;
      case 'Prospect':
        tagColor = AppTheme.info;
        break;
      default:
        tagColor = AppTheme.textMuted;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: tagColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        tag,
        style: TextStyle(
          fontSize: 11,
          color: tagColor,
        ),
      ),
    );
  }

  Widget _buildContactItem(Map<String, dynamic> contact) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Avatar(
              initials: contact['avatar'] as String,
              size: 48,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        contact['name'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        contact['lastContact'] as String,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.textMuted,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    contact['email'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 4,
                    children: (contact['tags'] as List)
                        .map((tag) => _buildTagChip(tag as String))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
