import 'package:flutter/material.dart';
import 'package:insta_following/helpers/l10n/localizer.dart';
import 'package:insta_following/helpers/locator.dart';
import 'package:insta_following/helpers/logger/logger.dart';
import 'package:insta_following/repositories/abstract/irepository.dart';

import 'package:insta_following/ui/theme/theme.dart';
import 'package:insta_following/ui/wigdets/profile_card.dart';


class FriendsView extends StatefulWidget {
  FriendsView({Key key, @required this.viewName}) : super(key: key);
  final String viewName;
  @override
  _FriendsViewState createState() => _FriendsViewState();
}

class _FriendsViewState extends State<FriendsView> {
   _FriendsViewState():
        _logger = locator.get<Logger>(),
        _repository = locator.get<IRepository>();

  final Logger _logger;
  final IRepository _repository;

  Localizer _localizer;

  @override
  void didChangeDependencies() {
    _localizer = Localizer.of(context);
    super.didChangeDependencies();
  }
 
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WhiteThemeUtils.appBarWithLinearGradient(context, widget.viewName),
      body: Container(
        child: ListView(
          children: <Widget>[
            ProfileCard(
              onTabFollowButton: () {},
              isFollow: true,
              profileUrl:
                  'https://images.unsplash.com/photo-1466112928291-0903b80a9466?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1053&q=80',
              title: 'mstfTuka',
              subTitle: 'Mustafa Türkan',
            ),
            ProfileCard(
              onTabFollowButton: () {},
              isFollow: false,
              profileUrl:
                  'https://images.unsplash.com/photo-1532074205216-d0e1f4b87368?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=681&q=80',
              title: '_uyanikedibe',
              subTitle: 'Edibe Uyanık',
            ),
            ProfileCard(
              onTabFollowButton: () {},
              isFollow: false,
              profileUrl:
                  'https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
              title: 'osmnali',
              subTitle: 'Osman Ali',
            ),
          ],
        ),
      ),
    );
  }
}
