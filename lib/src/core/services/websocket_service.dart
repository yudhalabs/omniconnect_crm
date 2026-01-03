import 'dart:async';
import 'dart:convert';

class WebSocketService {
  StreamSubscription? _subscription;
  final _messageController = StreamController<Map<String, dynamic>>.broadcast();
  final _connectionController = StreamController<bool>.broadcast();

  Stream<Map<String, dynamic>> get messageStream => _messageController.stream;
  Stream<bool> get connectionStream => _connectionController.stream;

  bool _isConnected = false;
  String? _baseUrl;

  bool get isConnected => _isConnected;

  void connect(String baseUrl, String token) async {
    _baseUrl = baseUrl;

    try {
      // In a real implementation, this would connect to a WebSocket server
      // For now, we'll simulate the connection
      _isConnected = true;
      _connectionController.add(true);

      // Simulate receiving messages
      _startMessageSimulation();
    } catch (e) {
      _isConnected = false;
      _connectionController.addError(e);
    }
  }

  void disconnect() {
    _subscription?.cancel();
    _subscription = null;
    _isConnected = false;
    _connectionController.add(false);
  }

  void send(String event, dynamic data) {
    if (!_isConnected) {
      throw Exception('WebSocket not connected');
    }

    final message = {
      'event': event,
      'data': data,
      'timestamp': DateTime.now().toIso8601String(),
    };

    // In a real implementation, this would send via WebSocket
    print('WebSocket send: $message');
  }

  void subscribe(String channel) {
    send('subscribe', {'channel': channel});
  }

  void unsubscribe(String channel) {
    send('unsubscribe', {'channel': channel});
  }

  void _startMessageSimulation() {
    // Simulate receiving messages for demo purposes
    _subscription = Stream.periodic(const Duration(seconds: 10)).listen((_) {
      if (_isConnected) {
        // Simulate a new message notification
        final message = {
          'type': 'message',
          'channel': 'whatsapp',
          'data': {
            'conversationId': 'conv_${DateTime.now().millisecondsSinceEpoch}',
            'sender': '+6281234567890',
            'message': 'Halo, ada yang bisa membantu?',
            'timestamp': DateTime.now().toIso8601String(),
          },
        };
        _messageController.add(message);
      }
    });
  }

  void dispose() {
    disconnect();
    _messageController.close();
    _connectionController.close();
  }
}
