import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:omniconnect_crm/src/core/di/service_locator.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  final _notificationStreamController =
      StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get notificationStream =>
      _notificationStreamController.stream;

  Future<void> initialize() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );

    // Request permissions
    await _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    await _notifications
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    await _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  void _onNotificationTap(NotificationResponse response) {
    final payload = response.payload;
    if (payload != null) {
      try {
        final data = jsonDecode(payload);
        _notificationStreamController.add(data);
      } catch (_) {
        _notificationStreamController.add({'payload': payload});
      }
    }
  }

  Future<void> show({
    required String title,
    required String body,
    String? payload,
    String channelId = 'omniconnect_default',
    String channelName = 'Default Notifications',
    Importance importance = Importance.defaultImportance,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'omniconnect_default',
      'Default Notifications',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
      icon: '@mipmap/ic_launcher',
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(
      DateTime.now().millisecondsSinceEpoch,
      title,
      body,
      details,
      payload: payload,
    );
  }

  Future<void> showMessageNotification({
    required String senderName,
    required String message,
    required String conversationId,
    String? senderAvatar,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'omniconnect_messages',
      'Messages',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      styleInformation: BigTextStyleInformation(
        message,
        summaryText: 'New message from $senderName',
        contentTitle: senderName,
      ),
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(
      DateTime.now().millisecondsSinceEpoch,
      senderName,
      message,
      details,
      payload: jsonEncode({
        'type': 'message',
        'conversationId': conversationId,
      }),
    );
  }

  Future<void> cancel(int id) async {
    await _notifications.cancel(id);
  }

  Future<void> cancelAll() async {
    await _notifications.cancelAll();
  }

  void dispose() {
    _notificationStreamController.close();
  }
}
