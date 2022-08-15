import 'package:conres_app/bloc/auth/auth-block.dart';
import 'package:conres_app/bloc/profile/profile-bloc.dart';
import 'package:conres_app/consts.dart';
import 'package:conres_app/http.dart';
import 'package:conres_app/repositories/auth-repo.dart';
import 'package:conres_app/websocket/websocket-listener.dart';
import 'package:conres_app/websocket/websocket.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../Services/update-claim-service.dart';
import '../Services/update-ticket-service.dart';
import '../repositories/profile-repo.dart';

// ignore: must_be_immutable
class DependencyProvider extends InheritedWidget {
  HttpClient? _httpClient;
  AuthBloc? _authBloc;
  ProfileBloc? _profileBloc;
  AuthRepo? _authRepo;
  ProfileRepo? _profileRepo;
  SharedPreferences? _sharedPreferences;
  WebSocketChannel? _webSocketChannel;
  WebSocketData? _webSocketData;
  WebSocketListener? _webSocketListener;
  UpdateClaimService? _updateClaimService;
  UpdateTicketService? _updateTicketService;

  DependencyProvider({Key? key, Widget? child})
      : assert(child != null),
        super(key: key, child: child!);

  WebSocketChannel? get webSocketChannel {
    _webSocketChannel ??=
        IOWebSocketChannel.connect("${ws}:2450/");
    return _webSocketChannel;
  }

  WebSocketListener? get webSocketListener{
    _webSocketListener ??=WebSocketListener();
    return _webSocketListener;
  }

  UpdateClaimService? get updateClaimService{
    _updateClaimService ??= UpdateClaimService();
    return _updateClaimService;
  }

  UpdateTicketService? get updateTicketService{
    _updateTicketService ??= UpdateTicketService();
    return _updateTicketService;
  }

  WebSocketData? get webSocketData {
    _webSocketData ??= WebSocketData();
    return _webSocketData;
  }

  Future<SharedPreferences> get sharedPreferences async {
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

  ProfileRepo get profileRepo {
    _profileRepo ??= ProfileRepo(httpClient: httpClient);
    return _profileRepo!;
  }

  AuthBloc get authBloc {
    _authBloc ??= AuthBloc(authRepo);
    return _authBloc!;
  }

  ProfileBloc get profileBloc {
    _profileBloc ??= ProfileBloc(profileRepo);
    return _profileBloc!;
  }

  static DependencyProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DependencyProvider>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
