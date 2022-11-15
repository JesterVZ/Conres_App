import 'dart:io';

import 'package:conres_app/Services/base-claim-send-service.dart';
import 'package:conres_app/Services/bottom-navigation-select-service.dart';
import 'package:conres_app/Services/profile-service.dart';
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
import '../Services/base-claim-send-service.dart';
import '../Services/main-claim-send-service.dart';
import '../Services/send-testimont-service.dart';
import '../Services/update-account-service.dart';
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
  List<Cookie>? _cookies;
  SharedPreferences? _sharedPreferences;
  WebSocketChannel? _webSocketChannel;
  WebSocketData? _webSocketData;
  WebSocketListener? _webSocketListener;
  UpdateClaimService? _updateClaimService;
  UpdateTicketService? _updateTicketService;
  BaseClaimSendService? _baseClaimSendService;
  SendTestimonyService? _sendTestimonyService;
  MainClaimSendService? _mainClaimSendService;
  UpdateAccountService? _updateAccountService;
  BottomNavigationSelectService? _bottomNavigationSelectService;
  ProfileService? _profileService;

  DependencyProvider({Key? key, Widget? child})
      : assert(child != null),
        super(key: key, child: child!);

  WebSocketChannel? get webSocketChannel {
    _webSocketChannel ??= IOWebSocketChannel.connect("${ws}:2450/");
    return _webSocketChannel;
  }

  WebSocketListener? get webSocketListener {
    _webSocketListener ??= WebSocketListener();
    return _webSocketListener;
  }

  List<Cookie>? get cookies {
    _cookies ??= [];
    return _cookies;
  }

  ProfileService? get profileService {
    _profileService ??= ProfileService();
    return _profileService;
  }

  UpdateClaimService? get updateClaimService {
    _updateClaimService ??= UpdateClaimService();
    return _updateClaimService;
  }

  MainClaimSendService? get mainClaimSendService {
    _mainClaimSendService ??= MainClaimSendService();
    return _mainClaimSendService;
  }

  UpdateTicketService? get updateTicketService {
    _updateTicketService ??= UpdateTicketService();
    return _updateTicketService;
  }

  UpdateAccountService? get updateAccountService{
    _updateAccountService ??= UpdateAccountService();
    return _updateAccountService;
  }

  BaseClaimSendService? get baseClaimSendService {
    _baseClaimSendService ??= BaseClaimSendService();
    return _baseClaimSendService;
  }

  SendTestimonyService? get sendTestimonyService {
    _sendTestimonyService ??= SendTestimonyService();
    return _sendTestimonyService;
  }

  BottomNavigationSelectService? get bottomNavigationSelectService {
    _bottomNavigationSelectService ??= BottomNavigationSelectService();
    return _bottomNavigationSelectService;
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
