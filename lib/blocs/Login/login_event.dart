part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class OnInstagramLogin extends LoginEvent{
  OnInstagramLogin({@required this.code});

  final String code;

}
