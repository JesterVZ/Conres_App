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

class GetAllInfo extends ProfileEvent{
  const GetAllInfo();
}

class GetClaims extends ProfileEvent{
  const GetClaims();
}

class GetTickets extends ProfileEvent{
  const GetTickets();
}

class GetMessages extends ProfileEvent{
  final String chat_id;
  final String page;
  final String last_message_id;
  const GetMessages(this.chat_id, this.page, this.last_message_id);
}