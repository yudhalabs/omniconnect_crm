import 'package:flutter/material.dart';
import 'package:omniconnect_crm/src/core/theme/app_theme.dart';
import 'package:omniconnect_crm/src/core/utils/responsive_helper.dart';
import 'package:omniconnect_crm/src/shared/widgets/app_scaffold.dart';
import 'package:omniconnect_crm/src/shared/widgets/common_widgets.dart';
import 'package:omniconnect_crm/src/shared/widgets/navigation.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  int _currentNavIndex = 1;
  int _selectedConversationIndex = 0;
  final TextEditingController _messageController = TextEditingController();

  final List<Map<String, dynamic>> _conversations = [
    {
      'id': '1',
      'name': 'John Doe',
      'avatar': 'JD',
      'channel': 'whatsapp',
      'lastMessage': 'Hi, I need help with my order #12345',
      'time': '2 min ago',
      'unread': 3,
      'messages': [
        {'text': 'Hi, I need help with my order #12345', 'isMe': false, 'time': '10:30 AM'},
        {'text': 'Sure, let me check that for you', 'isMe': true, 'time': '10:32 AM'},
        {'text': 'Your order is being processed and will ship today', 'isMe': false, 'time': '10:35 AM'},
        {'text': 'Great, thank you!', 'isMe': true, 'time': '10:36 AM'},
      ],
    },
    {
      'id': '2',
      'name': 'Jane Smith',
      'avatar': 'JS',
      'channel': 'instagram',
      'lastMessage': 'What are your working hours?',
      'time': '5 min ago',
      'unread': 1,
      'messages': [],
    },
    {
      'id': '3',
      'name': 'Bob Johnson',
      'avatar': 'BJ',
      'channel': 'whatsapp',
      'lastMessage': 'Thank you for your help!',
      'time': '10 min ago',
      'unread': 0,
      'messages': [],
    },
    {
      'id': '4',
      'name': 'Alice Brown',
      'avatar': 'AB',
      'channel': 'telegram',
      'lastMessage': 'Can I return this item?',
      'time': '15 min ago',
      'unread': 2,
      'messages': [],
    },
    {
      'id': '5',
      'name': 'Charlie Wilson',
      'avatar': 'CW',
      'channel': 'email',
      'lastMessage': 'Invoice attached for your review',
      'time': '30 min ago',
      'unread': 0,
      'messages': [],
    },
  ];

  final List<Map<String, dynamic>> _channels = [
    {'name': 'whatsapp', 'icon': Icons.chat, 'color': Color(0xFF25D366)},
    {'name': 'instagram', 'icon': Icons.camera_alt, 'color': Color(0xFFE1306C)},
    {'name': 'telegram', 'icon': Icons.send, 'color': Color(0xFF0088cc)},
    {'name': 'email', 'icon': Icons.email, 'color': Color(0xFF4285F4)},
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
            child: isDesktop
                ? _buildDesktopLayout(context)
                : _buildMobileLayout(context),
          ),
        ],
      ),
      bottomNavigationBar: isDesktop ? null : MainNavigation(
        currentIndex: _currentNavIndex,
        onIndexChanged: (index) => setState(() => _currentNavIndex = index),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 350,
          child: _buildConversationList(context),
        ),
        Container(
          width: 1,
          color: AppTheme.border,
        ),
        Expanded(
          child: _buildChatArea(context),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    if (_selectedConversationIndex >= 0 &&
        _selectedConversationIndex < _conversations.length) {
      return _buildChatArea(context);
    }
    return _buildConversationList(context);
  }

  Widget _buildConversationList(BuildContext context) {
    return Container(
      color: AppTheme.surface,
      child: Column(
        children: [
          _buildListHeader(context),
          Expanded(
            child: ListView.builder(
              itemCount: _conversations.length,
              itemBuilder: (context, index) =>
                  _buildConversationItem(_conversations[index], index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Inbox',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
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
          const SizedBox(height: 12),
          SearchBar(
            controller: TextEditingController(),
            hintText: 'Search conversations...',
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _channels.length,
              itemBuilder: (context, index) {
                final channel = _channels[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(channel['name'] as String),
                    selected: false,
                    onSelected: (selected) {},
                    avatar: Icon(
                      channel['icon'] as IconData,
                      size: 18,
                      color: channel['color'] as Color,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConversationItem(
      Map<String, dynamic> conversation, int index) {
    final isSelected = _selectedConversationIndex == index;

    return InkWell(
      onTap: () => setState(() => _selectedConversationIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primary.withOpacity(0.05)
              : Colors.transparent,
          border: Border(
            bottom: BorderSide(color: AppTheme.border.withOpacity(0.5)),
          ),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Avatar(
                  initials: conversation['avatar'] as String,
                  size: 48,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: _getChannelColor(conversation['channel'] as String),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppTheme.white, width: 2),
                    ),
                  ),
                ),
              ],
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
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
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
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          conversation['lastMessage'] as String,
                          style: TextStyle(
                            fontSize: 13,
                            color: AppTheme.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if ((conversation['unread'] as int) > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppTheme.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${conversation['unread']}',
                            style: const TextStyle(
                              color: AppTheme.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatArea(BuildContext context) {
    if (_conversations.isEmpty) {
      return const EmptyState(
        title: 'No conversations',
        message: 'Select a conversation to start chatting',
        icon: Icon(Icons.chat_outlined, size: 64),
      );
    }

    final conversation = _conversations[_selectedConversationIndex];
    final messages = conversation['messages'] as List;

    return Column(
      children: [
        _buildChatHeader(conversation),
        const Divider(height: 1),
        Expanded(
          child: messages.isNotEmpty
              ? ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) =>
                      _buildMessageBubble(messages[index]),
                )
              : const Center(
                  child: Text('No messages yet'),
                ),
        ),
        const Divider(height: 1),
        _buildMessageInput(),
      ],
    );
  }

  Widget _buildChatHeader(Map<String, dynamic> conversation) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        border: Border(
          bottom: BorderSide(color: AppTheme.border.withOpacity(0.5)),
        ),
      ),
      child: Row(
        children: [
          Avatar(
            initials: conversation['avatar'] as String,
            size: 40,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  conversation['name'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      _getChannelIcon(conversation['channel'] as String),
                      size: 14,
                      color: _getChannelColor(conversation['channel'] as String),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      conversation['channel'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.textMuted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message) {
    final isMe = message['isMe'] as bool;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isMe ? AppTheme.primary : AppTheme.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              message['text'] as String,
              style: TextStyle(
                color: isMe ? AppTheme.white : AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              message['time'] as String,
              style: TextStyle(
                fontSize: 10,
                color: (isMe ? AppTheme.white : AppTheme.textMuted).withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(12),
      color: AppTheme.surface,
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.attach_file),
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: _sendMessage,
            icon: const Icon(Icons.send),
            color: AppTheme.primary,
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _conversations[_selectedConversationIndex]['messages'].add({
          'text': _messageController.text,
          'isMe': true,
          'time': 'Now',
        });
        _conversations[_selectedConversationIndex]['lastMessage'] =
            _messageController.text;
        _messageController.clear();
      });
    }
  }

  Color _getChannelColor(String channel) {
    switch (channel.toLowerCase()) {
      case 'whatsapp':
        return const Color(0xFF25D366);
      case 'instagram':
        return const Color(0xFFE1306C);
      case 'telegram':
        return const Color(0xFF0088cc);
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
      case 'telegram':
        return Icons.send;
      case 'email':
        return Icons.email;
      default:
        return Icons.message;
    }
  }
}
