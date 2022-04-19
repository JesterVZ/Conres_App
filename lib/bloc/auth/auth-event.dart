import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class Event extends Equatable{
  const Event();

  @override
  List<Object> get props => [];
}

class RegisterEvent extends Event{
  final Object sender;
  final int type;

  const RegisterEvent(this.sender, this.type);
}

class LoginEvent extends Event{
  final String username;
  final String password;
  final int type;

  const LoginEvent(this.username, this.password, this.type);
}


class GetLoginEvent extends Event{
  const GetLoginEvent();
}

class GetTestimony extends Event{
  const GetTestimony();
}

class GetCookieStrEvent extends Event{
  final String username;
  final String password;
  final int type;
  const GetCookieStrEvent(this.username, this.password, this.type);
}

class GetLoginData extends Event{
  const GetLoginData();
}

class GetWebSocketData extends Event{
  const GetWebSocketData();
}

class LogoutEvent extends Event{
  const LogoutEvent();
}

class BindNewLS extends Event{
  final String number;
  final String address;
  const BindNewLS(this.number, this.address);
}

class GetContracts extends Event{
  const GetContracts();
}

class GetNumbers extends Event{
  const GetNumbers();
}