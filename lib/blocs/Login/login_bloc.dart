import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:insta_following/helpers/app_context.dart';
import 'package:insta_following/helpers/app_string.dart';
import 'package:insta_following/helpers/error/app_exception.dart';
import 'package:insta_following/helpers/logger/logger.dart';
import 'package:insta_following/models/authentication_token.dart';
import 'package:insta_following/models/menu_content.dart';
import 'package:insta_following/models/profile.dart';
import 'package:insta_following/repositories/abstract/irepository.dart';
import 'package:meta/meta.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({@required this.appContext, @required this.logger, @required this.context, @required this.repository})
      : assert(logger != null);

  final Logger logger;
  final AppContext appContext;
  final BuildContext context;
  final IRepository repository;

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is OnInstagramLogin) {
      yield* _mapLoginInstagram(event);
    }
  }

  Stream<LoginState> _mapLoginInstagram(OnInstagramLogin event) async* {
    try {
      yield LoginAuthenticating();
      var result = await repository.authenticate(event.code);


      if (result == null) {
        yield LoginFail(reason: AppString.nullResultAuthentication);
      } else {
        yield LoginSuccess(authToken: result,);
      }
    } on AppException catch (e) {
      yield LoginFail(reason: e.message);
      logger.error(e);
    } catch (e) {
      yield LoginFail(reason: AppString.unExpectedErrorOccurred);
      logger.error(e);
    }
  }
}
