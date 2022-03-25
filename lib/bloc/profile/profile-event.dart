import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object> get props => [];
}

class GetCookieStrEvent extends ProfileEvent{
  final String uri;
  const GetCookieStrEvent(this.uri);
}