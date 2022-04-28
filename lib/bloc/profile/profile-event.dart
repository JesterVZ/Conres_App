import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object> get props => [];
}

class GetCookieStrEvent extends ProfileEvent{
  final String username;
  final String password;
  final int type;
  const GetCookieStrEvent(this.username, this.password, this.type);
}

class GetLoginData extends ProfileEvent{
  const GetLoginData();
}

class GetWebSocketData extends ProfileEvent{
  const GetWebSocketData();
}

class LogoutEvent extends ProfileEvent{
  const LogoutEvent();
}

class BindNewLS extends ProfileEvent{
  final String number;
  final String address;
  const BindNewLS(this.number, this.address);
}

class GetContracts extends ProfileEvent{
  const GetContracts();
}

class GetNumbers extends ProfileEvent{
  const GetNumbers();
}

class GetClaims extends ProfileEvent{
  const GetClaims();
}

class GetTickets extends ProfileEvent{
  const GetTickets();
}