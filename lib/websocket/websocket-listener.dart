import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketListener {
  WebSocketChannel? webSocketChannel;
  Function? function;

  WebSocketListener({this.webSocketChannel, this.function});

  void listen() async {
    webSocketChannel!.stream.listen((event) {
      function!(event);
    });
    
  } 
}
