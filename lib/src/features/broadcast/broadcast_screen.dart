import 'package:flutter/material.dart';
import 'package:omniconnect_crm/src/core/theme/app_theme.dart';
import 'package:omniconnect_crm/src/core/utils/responsive_helper.dart';
import 'package:omniconnect_crm/src/shared/widgets/app_scaffold.dart';
import 'package:omniconnect_crm/src/shared/widgets/common_widgets.dart';
import 'package:omniconnect_crm/src/shared/widgets/navigation.dart';

class BroadcastScreen extends StatefulWidget {
  const BroadcastScreen({super.key});

  @override
  State<BroadcastScreen> createState() => _BroadcastScreenState();
}

class _BroadcastScreenState extends State<BroadcastScreen> {
  int _currentNavIndex = 3;
  int _selectedTab = 0;
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _campaigns = [
    {
      'id': '1',
      'name': 'Flash Sale Announcement',
      'status': 'sent',
      'channel': 'whatsapp',
      'sent': 1250,
      'delivered': 1235,
      'opened': 890,
      'clicked': 234,
      'date': '2024-01-10',
    },
    {
      'id': '2',
      'name': 'New Product Launch',
      'status': 'scheduled',
      'channel': 'whatsapp',
      'sent': 0,
      'delivered': 0,
      'opened': 0,
      'clicked': 0,
      'scheduledFor': '2024-01-15',
      'date': '2024-01-15',
    },
    {
      'id': '3',
      'name': 'Weekend Promo',
      'status': 'sent',
      'channel': 'instagram',
      'sent': 856,
      'delivered': 845,
      'opened': 567,
      'clicked': 123,
      'date': '2024-01-08',
    },
    {
      'id': '4',
      'name': 'Customer Feedback Survey',
      'status': 'draft',
      'channel': 'whatsapp',
      'sent': 0,
      'delivered': 0,
      'opened': 0,
      'clicked': 0,
      'date': null,
    },
    {
      'id': '5',
      'name': 'Holiday Greetings',
      'status': 'sent',
      'channel': 'email',
      'sent': 2100,
      'delivered': 2080,
      'opened': 1560,
      'clicked': 456,
      'date': '2024-01-01',
    },
  ];

  final List<Map<String, dynamic>> _templates = [
    {
      'id': '1',
      'name': 'Order Confirmation',
      'category': 'E-commerce',
      'preview': 'Thank you for your order...',
    },
    {
      'id': '2',
      'name': 'Shipping Update',
      'category': 'E-commerce',
      'preview': 'Your order has been shipped...',
    },
    {
      'id': '3',
      'name': 'Payment Receipt',
      'category': 'Finance',
      'preview': 'Payment received successfully...',
    },
    {
      'id': '4',
      'name': 'Appointment Reminder',
      'category': 'Healthcare',
      'preview': 'This is a reminder for your...',
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
            _buildTabs(),
            const SizedBox(height: 20),
            _selectedTab == 0
                ? _buildCampaignsSection(context)
                : _buildTemplatesSection(context),
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
              'Broadcast',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Create and manage your campaigns',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
        PrimaryButton(
          text: 'New Campaign',
          onPressed: () {},
          icon: const Icon(Icons.add, size: 18),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        _buildStatCard(
          'Total Sent',
          '4,206',
          Icons.send_outlined,
          AppTheme.primary,
        ),
        const SizedBox(width: 16),
        _buildStatCard(
          'Delivered',
          '4,160',
          Icons.done_all,
          AppTheme.success,
        ),
        const SizedBox(width: 16),
        _buildStatCard(
          'Opened',
          '3,017',
          Icons.visibility,
          AppTheme.secondary,
        ),
        const SizedBox(width: 16),
        _buildStatCard(
          'Clicked',
          '813',
          Icons.touch_app,
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

  Widget _buildTabs() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          _buildTabButton('Campaigns', 0),
          _buildTabButton('Templates', 1),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    final isSelected = _selectedTab == index;

    return Expanded(
      child: TextButton(
        onPressed: () => setState(() => _selectedTab = index),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
          backgroundColor: isSelected ? AppTheme.primary : Colors.transparent,
          foregroundColor: isSelected ? AppTheme.white : AppTheme.textSecondary,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildCampaignsSection(BuildContext context) {
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
          if (isDesktop)
            _buildCampaignsTable()
          else
            _buildCampaignsList(),
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
              hintText: 'Search campaigns...',
            ),
          ),
          const SizedBox(width: 12),
          DropdownButton<String>(
            hint: const Text('All Channels'),
            items: ['All Channels', 'WhatsApp', 'Instagram', 'Email']
                .map((channel) => DropdownMenuItem(
                      value: channel,
                      child: Text(channel),
                    ))
                .toList(),
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignsTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: double.infinity,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Campaign')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Channel')),
            DataColumn(label: Text('Sent')),
            DataColumn(label: Text('Opened')),
            DataColumn(label: Text('Clicked')),
            DataColumn(label: Text('Date')),
            DataColumn(label: Text('Actions')),
          ],
          rows: _campaigns.map((campaign) {
            return DataRow(
              cells: [
                DataCell(
                  Text(
                    campaign['name'] as String,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                DataCell(
                  StatusBadge(
                    status: campaign['status'] as String,
                    statusConfig: {
                      'sent': (AppTheme.success, 'Sent'),
                      'scheduled': (AppTheme.info, 'Scheduled'),
                      'draft': (AppTheme.textMuted, 'Draft'),
                    },
                  ),
                ),
                DataCell(
                  Row(
                    children: [
                      Icon(
                        _getChannelIcon(campaign['channel'] as String),
                        size: 18,
                        color: _getChannelColor(campaign['channel'] as String),
                      ),
                      const SizedBox(width: 8),
                      Text(campaign['channel'] as String),
                    ],
                  ),
                ),
                DataCell(Text('${campaign['sent']}')),
                DataCell(Text('${campaign['opened']}')),
                DataCell(Text('${campaign['clicked']}')),
                DataCell(Text(campaign['date'] as String? ?? '-')),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.visibility_outlined, size: 18),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit_outlined, size: 18),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.delete_outlined, size: 18),
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

  Widget _buildCampaignsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _campaigns.length,
      itemBuilder: (context, index) =>
          _buildCampaignItem(_campaigns[index]),
    );
  }

  Widget _buildCampaignItem(Map<String, dynamic> campaign) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    campaign['name'] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                StatusBadge(
                  status: campaign['status'] as String,
                  statusConfig: {
                    'sent': (AppTheme.success, 'Sent'),
                    'scheduled': (AppTheme.info, 'Scheduled'),
                    'draft': (AppTheme.textMuted, 'Draft'),
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  _getChannelIcon(campaign['channel'] as String),
                  size: 16,
                  color: _getChannelColor(campaign['channel'] as String),
                ),
                const SizedBox(width: 4),
                Text(
                  campaign['channel'] as String,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  'Sent: ${campaign['sent']}',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  'Opened: ${campaign['opened']}',
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

  Widget _buildTemplatesSection(BuildContext context) {
    final columns = ResponsiveHelper.getGridColumns(context);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.5,
      ),
      itemCount: _templates.length,
      itemBuilder: (context, index) =>
          _buildTemplateCard(_templates[index]),
    );
  }

  Widget _buildTemplateCard(Map<String, dynamic> template) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  template['category'] as String,
                  style: TextStyle(
                    fontSize: 11,
                    color: AppTheme.primary,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert, size: 18),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            template['name'] as String,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            template['preview'] as String,
            style: TextStyle(
              fontSize: 13,
              color: AppTheme.textSecondary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          Row(
            children: [
              TextButton(
                onPressed: () {},
                child: const Text('Preview'),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Use Template'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getChannelColor(String channel) {
    switch (channel.toLowerCase()) {
      case 'whatsapp':
        return const Color(0xFF25D366);
      case 'instagram':
        return const Color(0xFFE1306C);
      case 'email':
        return const Color(0xFF4285F4);
      default:
        return AppTheme.primary;
    }
  }

  IconData _getChannelIcon(String channel) {
    switch (channel.toLowerCase()) {
      case 'whatsapp':
        return Icons.chat;
      case 'instagram':
        return Icons.camera_alt;
      case 'email':
        return Icons.email;
      default:
        return Icons.send;
    }
  }
}
