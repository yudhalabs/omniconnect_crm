class AppConstants {
  // App Info
  static const String appName = 'OmniConnect CRM';
  static const String appVersion = '1.0.0';
  static const String buildNumber = '1';

  // API
  static const String apiBaseUrl = 'https://api.omniconnect.id/v1';
  static const String wsBaseUrl = 'wss://ws.omniconnect.id';

  // Storage Keys
  static const String authTokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userDataKey = 'user_data';
  static const String settingsKey = 'settings';

  // Default Values
  static const String defaultLanguage = 'id';
  static const int defaultPageSize = 20;

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);

  // Channel Types
  static const List<String> channelTypes = [
    'whatsapp',
    'instagram',
    'tiktok',
    'telegram',
    'email',
    'sms',
    'webchat',
    'voice',
  ];

  // Message Types
  static const List<String> messageTypes = [
    'text',
    'image',
    'video',
    'audio',
    'document',
    'location',
    'contact',
  ];

  // Conversation Status
  static const List<String> conversationStatuses = [
    'open',
    'pending',
    'resolved',
    'closed',
    'archived',
  ];

  // User Roles
  static const List<String> userRoles = [
    'owner',
    'admin',
    'manager',
    'supervisor',
    'agent',
    'viewer',
  ];

  // Permissions
  static const Map<String, List<String>> rolePermissions = {
    'owner': ['all'],
    'admin': [
      'manage_users',
      'manage_settings',
      'view_reports',
      'manage_automations',
      'manage_broadcasts',
    ],
    'manager': [
      'view_reports',
      'manage_automations',
      'manage_broadcasts',
      'manage_team',
    ],
    'supervisor': [
      'view_reports',
      'view_all_conversations',
      'assign_conversations',
    ],
    'agent': [
      'manage_conversations',
      'send_messages',
      'view_contacts',
    ],
    'viewer': [
      'view_conversations',
      'view_contacts',
    ],
  };
}
