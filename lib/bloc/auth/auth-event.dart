import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
/* 
auth-event
Event-ы для auth-bloc

Copyright © 2022 DEGAM-Soft Жулин Владимир. All rights reserved.
 */
abstract class Event extends Equatable {
  const Event();

  @override
  List<Object> get props => [];
}

class RegisterEvent extends Event {
  final Object sender;
  final int type;

  const RegisterEvent(this.sender, this.type);
}

class LoginEvent extends Event {
  final String username;
  final String password;
  final int type;

  const LoginEvent(this.username, this.password, this.type);
}

class CookieLogin extends Event {
  const CookieLogin();
}

class GetLoginEvent extends Event {
  const GetLoginEvent();
}

class GetTestimony extends Event {
  const GetTestimony();
}

class GetStores extends Event {
  const GetStores();
}
