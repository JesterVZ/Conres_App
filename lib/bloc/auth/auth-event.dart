import 'package:equatable/equatable.dart';

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