import 'package:stomp_dart_client/stomp_dart_client.dart';

class StompWebSocketService {
  static final StompWebSocketService _instance = StompWebSocketService._internal();

  factory StompWebSocketService() => _instance;

  StompClient? _stompClient;
  bool _isConnected = false;

  // ✅ Use `ws://` and add `/websocket` if backend uses SockJS
  final String _webSocketUrl = 'ws://34.238.14.72:8080/ws/websocket';

  StompWebSocketService._internal();

  void connect({
    required String topic,
    required Function(String message) onMessage,
    Function()? onConnectCallback,
    Function(dynamic error)? onError,
  }) {
    if (_isConnected) {
      print("🔄 STOMP is already connected.");
      return;
    }

    print("🔌 Connecting to STOMP...");

    _stompClient = StompClient(
      config: StompConfig(
        url: _webSocketUrl,
        onConnect: (StompFrame frame) {
          print('✅ STOMP connected');
          _isConnected = true;

          try {
            _stompClient?.subscribe(
              destination: topic,
              callback: (StompFrame frame) {
                if (frame.body != null) {
                  print("📩 Received message: ${frame.body}");
                  onMessage(frame.body!);
                } else {
                  print("⚠️ Empty frame received.");
                }
              },
            );
            print("📡 Subscribed to topic: $topic");
          } catch (e) {
            print("❌ Subscription error: $e");
          }

          if (onConnectCallback != null) onConnectCallback();
        },
        onWebSocketError: (dynamic error) {
          print('❌ STOMP WebSocket error: $error');
          _isConnected = false;
          if (onError != null) onError(error);
        },
        onDisconnect: (StompFrame? frame) {
          print('🔌 STOMP disconnected');
          _isConnected = false;
        },
        onStompError: (StompFrame frame) {
          print('💥 STOMP protocol error: ${frame.body}');
          _isConnected = false;
        },
        onDebugMessage: (String message) {
          print("🐞 DEBUG: $message");
        },
        heartbeatOutgoing: const Duration(seconds: 10),
        heartbeatIncoming: const Duration(seconds: 10),
        reconnectDelay: const Duration(seconds: 5),
      ),
    );

    _stompClient?.activate();
  }

  bool get isConnected => _isConnected;

  void sendMessage({
    required String destination,
    required String body,
  }) {
    if (_isConnected && _stompClient != null) {
      _stompClient!.send(destination: destination, body: body);
      print("📤 Message sent to $destination: $body");
    } else {
      print("⚠️ Cannot send message. STOMP not connected.");
    }
  }

  void disconnect() {
    if (_stompClient != null) {
      _stompClient?.deactivate();
      _isConnected = false;
      print("🔒 STOMP connection closed.");
    }
  }
}
