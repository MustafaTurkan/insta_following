import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_following/blocs/info/info_bloc.dart';
import 'package:insta_following/helpers/l10n/localizer.dart';
import 'package:insta_following/helpers/locator.dart';
import 'package:insta_following/helpers/logger/logger.dart';
import 'package:insta_following/models/menu_content.dart';
import 'package:insta_following/models/profile.dart';
import 'package:insta_following/repositories/abstract/irepository.dart';
import 'package:insta_following/ui/app_navigator.dart';
import 'package:insta_following/ui/theme/app_theme.dart';
import 'package:insta_following/ui/theme/theme.dart';
import 'package:insta_following/ui/wigdets/list_view_with_row.dart';
import 'package:insta_following/ui/wigdets/menu_button.dart';
import 'package:insta_following/ui/wigdets/network_img_with_loading.dart';
import 'package:insta_following/ui/wigdets/waiting_view.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  _HomeViewState()
      : _navigator = locator.get<AppNavigator>(),
        _logger = locator.get<Logger>(),
        _repository = locator.get<IRepository>();

  final AppNavigator _navigator;
  final Logger _logger;
  final IRepository _repository;

  AppTheme _appTheme;
  Localizer _localizer;

  @override
  void didChangeDependencies() {
    _appTheme = Provider.of<AppTheme>(context);
    _localizer = Localizer.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InfoBloc>(
        create: (context) => InfoBloc(logger: _logger, repository: _repository),
        child: Builder(
          builder: (context) {
            var bloc = BlocProvider.of<InfoBloc>(context);
            initialLoadInfo(bloc);
            return BlocBuilder<InfoBloc, InfoState>(builder: (context, state) {
              if (state is InfoLoadSuccess) {
                return Scaffold(
                  appBar: AppBar(
                    leading: Container(),
                    elevation: 0,
                    backgroundColor: _appTheme.colors.primary,
                    centerTitle: true,
                    title: Text(
                      '${state.profile.firstName} ${state.profile.lastName}',
                      style: _headerTextTitleStyle(),
                    ),
                  ),
                  body: Container(
                    child: Column(
                      children: <Widget>[
                        Expanded(flex: 4, child: _profileDetail(state.profile)),
                        Expanded(flex: 7, child: _menu(state.menu))
                      ],
                    ),
                  ),
                );
              } else {
                return WaitingView();
              }
            });
          },
        ));
  }

  Widget _profileDetail(Profile profile) {
    return Material(
      elevation: 1,
      child: Builder(
        builder: (context) {
          return Container(
            decoration: _boxDecoration(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          profile.followersCount.toString(),
                          style: _headerTextTitleStyle(),
                        ),
                        Text(
                          _localizer.followers,
                          style: _headerTextBodyStyle(),
                        )
                      ],
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
                          child: ClipOval(child: NetworkImgWithLoading(imageUrl: profile.imageUrl))),
                    ),
                    Column(
                      children: <Widget>[
                        Text(profile.followedCount.toString(), style: _headerTextTitleStyle()),
                        Text(_localizer.following, style: _headerTextBodyStyle())
                      ],
                    ),
                  ],
                ),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            profile.avglike.toString(),
                            style: _headerTextSubTitleStyle(),
                          ),
                          Text(
                            _localizer.averageLikes,
                            style: _headerTextSubStyle(),
                          )
                        ],
                      ),
                      VerticalDivider(
                        color: _appTheme.colors.fontLight,
                        width: 1,
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            profile.postCount.toString(),
                            style: _headerTextSubTitleStyle(),
                          ),
                          Text(
                            _localizer.posts,
                            style: _headerTextSubStyle(),
                          )
                        ],
                      ),
                      VerticalDivider(
                        width: 1,
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            profile.avgComment.toString(),
                            style: _headerTextSubTitleStyle(),
                          ),
                          Text(
                            _localizer.averageComment,
                            style: _headerTextSubStyle(),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _menu(List<MenuContent> menu) {
    return ListViewWithRow<MenuContent>(
        items: menu,
        rowCount: 2,
        itemBuilder: (item) {
          return MenuButton(
            title: item.count > 0 ? item.count.toString() : null,
            onPressed: () {
               //TODO(Mustafa):Bloc frieds olucak ve oraya göndericeğimiz menu şekline göre servicedeki asenkron methodu çağrıcak ve state atıcak bütün friends menuleri tek bir succses staten ayni tip model dönecek Bloc aynı State aynı event aynı sadece evente gidicek menu parametresi farklı ona görede friend load etme servicesi farklı
              _navigator.pushMenu(item.name,context);
            },
            subTitle: _localizer.translate(item.name),
            images: <Widget>[
              ClipOval(child: NetworkImgWithLoading(height: 8, width: 8, imageUrl: item.urlFirst)),
              ClipOval(child: NetworkImgWithLoading(height: 8, width: 8, imageUrl: item.urlSecond)),
              ClipOval(child: NetworkImgWithLoading(height: 8, width: 8, imageUrl: item.urlTird))
            ],
          );
        });
  }

  TextStyle _headerTextTitleStyle() {
    return _appTheme.data.textTheme.headline5
        .copyWith(color: _appTheme.colors.fontLight, fontWeight: FontWeight.normal);
  }

  TextStyle _headerTextBodyStyle() {
    return _appTheme.data.textTheme.caption.copyWith(color: _appTheme.colors.fontLight, fontWeight: FontWeight.normal);
  }

  TextStyle _headerTextSubStyle() {
    return _appTheme.data.textTheme.caption.copyWith(color: _appTheme.colors.fontLight, fontWeight: FontWeight.normal);
  }

  TextStyle _headerTextSubTitleStyle() {
    return _appTheme.data.textTheme.subtitle1
        .copyWith(color: _appTheme.colors.fontLight, fontWeight: FontWeight.normal);
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      gradient: WhiteThemeUtils.linearGradient(),
    );
  }


  void initialLoadInfo(InfoBloc bloc) {
    if (bloc.state is InfoInitial) {
      bloc.add(OnInfoLoad());
    }
  }
}
