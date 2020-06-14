import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get_it/get_it.dart';
import 'package:insta_following/blocs/bloc_delegate.dart';
import 'package:insta_following/helpers/app_context.dart';
import 'package:insta_following/helpers/error/app_error_handler.dart';
import 'package:insta_following/helpers/logger/log_debug_print.dart';
import 'package:insta_following/helpers/logger/logger.dart';
import 'package:insta_following/repositories/abstract/irepository.dart';
import 'package:insta_following/repositories/concrete/app_repository.dart';
import 'package:insta_following/services/fake_instagram_api_service.dart';
import 'package:insta_following/services/instagram_api_service.dart';
import 'package:insta_following/ui/app_navigator.dart';


GetIt locator=GetIt.instance;
void setupLocator()
{
 final appContext = AppContext();
 locator.registerLazySingleton<AppContext>(()=>appContext);
 locator.registerLazySingleton(()=>AppNavigator());
 locator.registerLazySingleton(() => Logger());
 locator.registerFactory(() => FlutterWebviewPlugin());
 locator.registerLazySingleton<InstagramApiService>(() => FakeInstagramApiService(appContext,Logger()));
 locator.registerLazySingleton<IRepository>(() => AppRepository(locator.get<InstagramApiService>()));
 run();
}

  void run(){
    BlocSupervisor.delegate = AppBlocDelegate();
    AppErrorHandler.onReport = reportError;
    AppErrorHandler.onShow = showError;
    AppErrorHandler.track(() async {
      WidgetsFlutterBinding.ensureInitialized();
      buildLogListeners();
    });
  }

  void buildLogListeners() {
     Logger.onLog.listen(LogDebugPrint.write);
  }


  
  Future<void> showError(AppErrorReport appError) async {
    assert(AppNavigator.key.currentState != null, 'Navigator state null!');
      //TODO(Mustafa):Add Dialog
  }

    Future<void> reportError(AppErrorReport appError) async {
    var sb =  StringBuffer();
    sb.write('AppErrorReport');
    sb.write(appError.error?.toString() ?? 'error type empty!');
    if (kDebugMode) {
      sb.write(appError.stackTrace?.toString() ?? 'stacktrace empty!');
    }
    //TODO(Mustafa): add device info to log.
    //TODO(Mustafa): report  FireBase
    locator.get<Logger>().error(sb.toString());
  }