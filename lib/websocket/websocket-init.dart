import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketListener {
  WebSocketChannel? webSocketChannel;
  Function function;

  WebSocketListener({required this.webSocketChannel, required this.function});

  void listen() async {
    webSocketChannel!.stream.listen((event) {
      function();
    });
  }
}
