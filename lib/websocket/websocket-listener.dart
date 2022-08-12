import 'dart:async';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../consts.dart';

class WebSocketListener {
  WebSocketChannel? webSocketChannel;
  Function? function;
  Function? reconnect;
  WebSocketListener({this.webSocketChannel, this.function, this.reconnect});

  void listen() async {
    try {
      webSocketChannel!.stream.listen(
          (event) {
            function!(event);
          },
          cancelOnError: true,
          onError: (e) {
            webSocketChannel = IOWebSocketChannel.connect("${ws}:2450/");
          });
    } catch (e) {
      webSocketChannel = IOWebSocketChannel.connect("${ws}:2450/");
    }
  }

  void stop() {
    webSocketChannel = null;
  }
}
