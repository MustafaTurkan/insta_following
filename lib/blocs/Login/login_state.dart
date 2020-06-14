part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginAuthenticating extends LoginState {}
class LoginSuccess extends LoginState {
  LoginSuccess({@required this.authToken});
  final AuthenticationToken authToken;
}
class LoginFail extends LoginState {
  LoginFail({@required this.reason});
  final String reason;
  @override
  String toString() => 'LoginFail { reason: $reason }';
}
