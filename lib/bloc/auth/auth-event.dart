import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class Event extends Equatable{
  const Event();

  @override
  List<Object> get props => [];
}

class RegisterEvent extends Event{
  final Object sender;

  const RegisterEvent(this.sender);
}

class LoginEvent extends Event{
  final String username;
  final String password;

  const LoginEvent(this.username, this.password);
}

class GetLoginEvent extends Event{
  const GetLoginEvent();
}

class GetTestimony extends Event{
  const GetTestimony();
}
