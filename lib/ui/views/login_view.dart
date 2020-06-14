import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:insta_following/blocs/Login/login_bloc.dart';
import 'package:insta_following/helpers/app_constants.dart';
import 'package:insta_following/helpers/app_context.dart';
import 'package:insta_following/helpers/l10n/localizer.dart';
import 'package:insta_following/helpers/locator.dart';
import 'package:insta_following/helpers/logger/logger.dart';
import 'package:insta_following/repositories/abstract/irepository.dart';
import 'package:insta_following/ui/app_navigator.dart';
import 'package:insta_following/ui/theme/app_theme.dart';
import 'package:insta_following/ui/theme/theme.dart';
import 'package:insta_following/ui/wigdets/delayed_animation.dart';
import 'package:insta_following/ui/wigdets/dialogs/message_dialog.dart';
import 'package:insta_following/ui/wigdets/dialogs/wait_dialog.dart';
import 'package:provider/provider.dart';
import 'package:insta_following/helpers/extensions/string_extensions.dart';

class LoginView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with SingleTickerProviderStateMixin {
  _LoginViewState()
      : _logger = locator.get<Logger>(),
        _appContext = locator.get<AppContext>(),
        _webviewPlugin = locator.get<FlutterWebviewPlugin>(),
        _repository = locator.get<IRepository>(),
        _appNavigator = locator.get<AppNavigator>();

  final Logger _logger;
  final int _delayedAmount = 500;
  final AppContext _appContext;
  final FlutterWebviewPlugin _webviewPlugin;
  final IRepository _repository;
  final AppNavigator _appNavigator;

  AppTheme _appTheme;
  Localizer _localizer;
  double _scale;
  AnimationController _controller;
  WaitDialog _waitDialog;

  @override
  void didChangeDependencies() {
    _appTheme = Provider.of<AppTheme>(context);
    _localizer = Localizer.of(context);
    _waitDialog ??= WaitDialog(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _logger.debug('Uygulama Başlıyor Test Logu');
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return BlocProvider(
        create: (context) =>
            LoginBloc(appContext: _appContext, context: context, logger: _logger, repository: _repository),
        child: Builder(builder: (context) {
          return Scaffold(
            body: BlocListener<LoginBloc, LoginState>(
                bloc: BlocProvider.of<LoginBloc>(context),
                listener: (context, state) async {
                  if (state is LoginAuthenticating && !_waitDialog.isShowing) {
                    _waitDialog.show();
                  } else if (state is LoginSuccess) {
                    await _waitDialog.hide();
                     _appContext.registerAppToken=state.authToken;
                    _appNavigator.pushHomeClearHistory(context);
                  } else if (state is LoginFail) {
                    await MessageDialog.error(context: context, content: state.reason);
                  }
                },
                child: ClipPath(
                  clipper: _WavePathClipper(),
                  child: Container(
                      child: Container(
                    decoration: BoxDecoration(
                      gradient: WhiteThemeUtils.linearGradient(),
                    ),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                          ),
                          AvatarGlow(
                            endRadius: 90,
                            duration: Duration(seconds: 2),
                            glowColor: _appTheme.colors.canvas,
                            repeat: true,
                            repeatPauseDuration: Duration(seconds: 2),
                            startDelay: Duration(seconds: 1),
                            child: Material(
                                elevation: 8,
                                shape: CircleBorder(),
                                child: CircleAvatar(
                                  backgroundColor: _appTheme.colors.fontLight,
                                  radius: 50,
                                  child: FlutterLogo(
                                    size: 50,
                                  ),
                                )),
                          ),
                          DelayedAnimation(
                            delay: _delayedAmount + 1000,
                            child: Text(
                              _localizer.appName,
                              style: _appTheme.data.textTheme.headline4
                                  .copyWith(color: _appTheme.colors.fontLight, fontWeight: FontWeight.bold),
                            ),
                          ),
                          DelayedAnimation(
                            delay: _delayedAmount + 2000,
                            child: Text(
                              _localizer.loginHeader,
                              style: _appTheme.data.textTheme.headline5
                                  .copyWith(color: _appTheme.colors.fontLight, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 120,
                          ),
                          DelayedAnimation(delay: _delayedAmount + 3000, child: _loginButton(context)),
                                                SizedBox(
                            height: 30,
                          ),    
                                 DelayedAnimation(
                              delay: _delayedAmount + 4000,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  _localizer.loginInformation,
                                  textAlign: TextAlign.center,
                                  style: _appTheme.data.textTheme.bodyText2
                                      .copyWith(color: _appTheme.colors.fontLight, fontWeight: FontWeight.normal),
                                ),
                              )),
                          SizedBox(
                            height: 50,
                          ),
                          DelayedAnimation(
                            delay: _delayedAmount + 5000,
                            child: Text(
                              _localizer.loginContract,
                              textAlign: TextAlign.center,
                              style: _appTheme.data.textTheme.bodyText2.copyWith(
                                  color: _appTheme.colors.fontLight,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
                )),
          );
        }));
  }

  Widget _loginButton(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: (details) {
        _onTapUp(details, context);
      },
      child: Transform.scale(
        scale: _scale,
        child: Container(
          height: 45,
          width: 270,
          decoration: BoxDecoration(
            borderRadius: _appTheme.data.buttonBorderRadius(),
            color: Colors.white,
          ),
          child: Center(
            child: Text(
              _localizer.loginWithInstagram,
              textAlign: TextAlign.center,
              style: _appTheme.data.textTheme.button.copyWith(color: _appTheme.colors.primary, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details, BuildContext context) {
    _controller.reverse();
    var bloc = BlocProvider.of<LoginBloc>(context);
    _onInstagramLogin(bloc);
  }

  void _onInstagramLogin(LoginBloc bloc) {
    var _webViewUrl =
        '${AppConstants.baseUrl}/oauth/authorize?client_id=${AppConstants.appId}&redirect_uri=${AppConstants.redirectUri}&response_type=code&scope=user_profile,user_media';
    _webviewPlugin.launch(_webViewUrl,
        rect: Rect.fromLTWH(0, 0, MediaQuery.of(context).size.width, MediaQuery.of(context).size.height - 10));
    _webviewPlugin.onUrlChanged.listen((event) {
      if (!event.contains(AppConstants.appId) && event.contains('code=')) {
        var code = _code(event);
        if (!code.isNullOrEmpty()) {
          bloc.add(OnInstagramLogin(code: code));
        }
        _webviewPlugin.close();
      }
    });
  }

  String _code(String val) {
    var subString = 'code=';
    if (val.toString().contains(subString)) {
      val = val.split(subString)[1];
      val = val.substring(0, val.lastIndexOf('#'));
      return val;
    }
    return '';
  }
}

class _WavePathClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    //minimum required size dan küçük ise(keyboard açık ise) kırpma
    if (size.height < 100) {
      return null;
    }
    var path = Path();
    path.lineTo(0, size.height - 30);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width - (size.width / 3.25), size.height - 60);
    var secondEndPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
