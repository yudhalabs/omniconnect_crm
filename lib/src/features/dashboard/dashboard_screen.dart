import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:omniconnect_crm/src/core/theme/app_theme.dart';
import 'package:omniconnect_crm/src/core/utils/responsive_helper.dart';
import 'package:omniconnect_crm/src/shared/widgets/app_scaffold.dart';
import 'package:omniconnect_crm/src/shared/widgets/common_widgets.dart';
import 'package:omniconnect_crm/src/shared/widgets/navigation.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentNavIndex = 0;

  final List<Map<String, dynamic>> _stats = [
    {
      'title': 'Total Conversations',
      'value': '2,847',
      'change': '+12%',
      'isPositive': true,
      'icon': Icons.chat_bubble_outline,
      'color': AppTheme.primary,
    },
    {
      'title': 'Messages Today',
      'value': '1,234',
      'change': '+8%',
      'isPositive': true,
      'icon': Icons.message_outlined,
      'color': AppTheme.secondary,
    },
    {
      'title': 'Avg Response Time',
      'value': '2m 34s',
      'change': '-15%',
      'isPositive': true,
      'icon': Icons.timer_outlined,
      'color': AppTheme.accent,
    },
    {
      'title': 'Customer Satisfaction',
      'value': '94.5%',
      'change': '+2%',
      'isPositive': true,
      'icon': Icons.sentiment_satisfied_outlined,
      'color': AppTheme.success,
    },
  ];

  final List<Map<String, dynamic>> _recentConversations = [
    {
      'name': 'John Doe',
      'avatar': 'JD',
      'channel': 'whatsapp',
      'message': 'Hi, I need help with my order...',
      'time': '2 min ago',
      'status': 'open',
    },
    {
      'name': 'Jane Smith',
      'avatar': 'JS',
      'channel': 'instagram',
      'message': 'What are your working hours?',
      'time': '5 min ago',
      'status': 'pending',
    },
    {
      'name': 'Bob Johnson',
      'avatar': 'BJ',
      'channel': 'whatsapp',
      'message': 'Thank you for your help!',
      'time': '10 min ago',
      'status': 'resolved',
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
            const SizedBox(height: 24),
            _buildStatsGrid(context),
            const SizedBox(height: 24),
            _buildChartsRow(context),
            const SizedBox(height: 24),
            _buildRecentConversations(context),
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
              'Dashboard',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Welcome back, Yudi!',
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
              text: 'Export Report',
              onPressed: () {},
              icon: const Icon(Icons.download_outlined, size: 18),
            ),
            const SizedBox(width: 12),
            PrimaryButton(
              text: 'New Campaign',
              onPressed: () {},
              icon: const Icon(Icons.add, size: 18),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsGrid(BuildContext context) {
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
      itemCount: _stats.length,
      itemBuilder: (context, index) => _buildStatCard(_stats[index]),
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: (stat['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  stat['icon'] as IconData,
                  color: stat['color'] as Color,
                  size: 24,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: (stat['isPositive'] as bool)
                      ? AppTheme.success.withOpacity(0.1)
                      : AppTheme.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  stat['change'] as String,
                  style: TextStyle(
                    color: (stat['isPositive'] as bool)
                        ? AppTheme.success
                        : AppTheme.error,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stat['value'] as String,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                stat['title'] as String,
                style: TextStyle(
                  fontSize: 13,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChartsRow(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isMobile)
          Column(
            children: [
              _buildConversationChart(),
              const SizedBox(height: 16),
              _buildChannelDistribution(),
            ],
          )
        else
          Expanded(
            flex: 2,
            child: _buildConversationChart(),
          ),
        if (!isMobile) const SizedBox(width: 16),
        if (!isMobile)
          Expanded(
            flex: 1,
            child: _buildChannelDistribution(),
          ),
      ],
    );
  }

  Widget _buildConversationChart() {
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
            'Conversation Trends',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  horizontalInterval: 20,
                  verticalInterval: 1,
                  drawHorizontalLine: true,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: AppTheme.border.withOpacity(0.3),
                    strokeWidth: 1,
                  ),
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 20,
                      getTitlesWidget: (value, _) => Text(
                        value.toInt().toString(),
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, _) {
                        final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                        if (value.toInt() < days.length) {
                          return Text(
                            days[value.toInt()],
                            style: const TextStyle(
                              fontSize: 10,
                              color: AppTheme.textSecondary,
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 30),
                      FlSpot(1, 45),
                      FlSpot(2, 38),
                      FlSpot(3, 55),
                      FlSpot(4, 48),
                      FlSpot(5, 60),
                      FlSpot(6, 52),
                    ],
                    color: AppTheme.primary,
                    barWidth: 3,
                    dotSize: 4,
                    isCurved: true,
                    gradient: LinearGradient(
                      colors: [AppTheme.primary.withOpacity(0.8), AppTheme.primary.withOpacity(0.3)],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChannelDistribution() {
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
            'Channels',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 150,
            child: PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    value: 45,
                    color: AppTheme.primary,
                    title: '45%',
                    radius: 50,
                    titleStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  PieChartSectionData(
                    value: 30,
                    color: AppTheme.secondary,
                    title: '30%',
                    radius: 50,
                    titleStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  PieChartSectionData(
                    value: 15,
                    color: AppTheme.accent,
                    title: '15%',
                    radius: 50,
                    titleStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  PieChartSectionData(
                    value: 10,
                    color: AppTheme.info,
                    title: '10%',
                    radius: 50,
                    titleStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
                centerSpaceRadius: 40,
                sectionsSpace: 2,
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildChannelLegend(),
        ],
      ),
    );
  }

  Widget _buildChannelLegend() {
    final channels = [
      {'name': 'WhatsApp', 'color': AppTheme.primary},
      {'name': 'Instagram', 'color': AppTheme.secondary},
      {'name': 'Telegram', 'color': AppTheme.accent},
      {'name': 'Email', 'color': AppTheme.info},
    ];

    return Column(
      children: channels.map((channel) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: channel['color'] as Color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                channel['name'] as String,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRecentConversations(BuildContext context) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Conversations',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _recentConversations.length,
            itemBuilder: (context, index) =>
                _buildConversationItem(_recentConversations[index]),
          ),
        ],
      ),
    );
  }

  Widget _buildConversationItem(Map<String, dynamic> conversation) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Avatar(
            initials: conversation['avatar'] as String,
            size: 44,
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
                      conversation['name'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      conversation['time'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.textMuted,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  conversation['message'] as String,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppTheme.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          StatusBadge(
            status: conversation['status'] as String,
            statusConfig: {
              'open': (AppTheme.success, 'Open'),
              'pending': (AppTheme.warning, 'Pending'),
              'resolved': (AppTheme.textMuted, 'Resolved'),
            },
          ),
        ],
      ),
    );
  }
}
