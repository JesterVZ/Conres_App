import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthEvent extends Equatable{
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class RegisterEvent extends AuthEvent{
  final Object sender;

  const RegisterEvent(this.sender);
}

class LoginEvent extends AuthEvent{
  final String username;
  final String password;

  const LoginEvent(this.username, this.password);
}

class CheckLoginEvent extends AuthEvent{
  final SharedPreferences preferences;
  const CheckLoginEvent(this.preferences);
}

class GetLoginEvent extends AuthEvent{
  final SharedPreferences preferences;
  const GetLoginEvent(this.preferences);
}