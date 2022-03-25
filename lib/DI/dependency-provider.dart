import 'package:conres_app/bloc/auth/auth-block.dart';
import 'package:conres_app/http.dart';
import 'package:conres_app/repositories/auth-repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// ignore: must_be_immutable
class DependencyProvider extends InheritedWidget{
  HttpClient? _httpClient;
  AuthBloc? _authBloc;
  AuthRepo? _authRepo;
  SharedPreferences? _sharedPreferences;
  WebSocketChannel? _webSocketChannel;

  DependencyProvider({Key? key, Widget? child})
      : assert(child != null),
        super(key: key, child: child!);

  WebSocketChannel? get webSocketChannel{
    _webSocketChannel ??= IOWebSocketChannel.connect("wss://promo.dev.conres.ru:2450/");
    return _webSocketChannel;
  }
  Future<SharedPreferences> get sharedPreferences async{
    _sharedPreferences ??= await SharedPreferences.getInstance();
    return _sharedPreferences!;
  }

  HttpClient get httpClient {
    _httpClient ??= HttpClient();
    return _httpClient!;
  }

  AuthRepo get authRepo {
    _authRepo ??= AuthRepo(httpClient: httpClient);
    return _authRepo!;
  }

  AuthBloc get authBloc {
    _authBloc ??= AuthBloc(authRepo);
    return _authBloc!;
  }


  static DependencyProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DependencyProvider>();
  }


  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}