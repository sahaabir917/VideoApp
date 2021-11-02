part of 'login_bloc.dart';


@immutable
abstract class LoginEvent{}

class FetchLoginInfo extends LoginEvent{
  final String username;
  final String password;

  FetchLoginInfo(this.username, this.password);




}