import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:insta_following/blocs/info/info_bloc.dart';
import 'package:insta_following/helpers/app_string.dart';
import 'package:insta_following/helpers/l10n/localizer.dart';
import 'package:insta_following/helpers/locator.dart';
import 'package:insta_following/helpers/logger/logger.dart';
import 'package:insta_following/repositories/abstract/irepository.dart';
import 'package:insta_following/ui/app_navigator.dart';
import 'package:insta_following/ui/theme/theme.dart';
import 'package:insta_following/ui/views/login_view.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'ui/theme/app_theme.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp()
      :_logger = locator.get<Logger>(),
        _repository = locator.get<IRepository>();
        
  final Logger _logger;
  final IRepository _repository;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [..._providers()],
        child: MaterialApp(
          title: AppString.appName,
          localizationsDelegates: _localizationsDelegates(),
          supportedLocales: _supportedLocales(),
          builder: _builder,
          navigatorKey: AppNavigator.key,
          navigatorObservers: [AppNavigator.routeObserver],
          home: LoginView(),
        ));
  }

  Widget _builder(BuildContext context, Widget child) {
    var theme = Provider.of<AppTheme>(context);
    if (!theme.initialized) {
      theme.setTheme(buildWhiteTheme(context));
    }
    return Theme(data: theme.data, child: child);
  }

  List<SingleChildWidget> _providers() {
    Provider.debugCheckInvalidValueType = null;
    return [
      ChangeNotifierProvider<AppTheme>(create: (context) => AppTheme()),
      BlocProvider<InfoBloc>(create: (context)=>InfoBloc(logger: _logger,repository:_repository),)
    ];
  }

  Iterable<LocalizationsDelegate<dynamic>> _localizationsDelegates() {
    return [AppLocalizationsDelegate(), GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate];
  }

  Iterable<Locale> _supportedLocales() {
    return [const Locale('en'), const Locale('tr')];
  }
}
