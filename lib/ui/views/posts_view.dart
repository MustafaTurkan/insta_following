import 'package:flutter/material.dart';
import 'package:insta_following/helpers/l10n/localizer.dart';
import 'package:insta_following/helpers/locator.dart';
import 'package:insta_following/helpers/logger/logger.dart';
import 'package:insta_following/repositories/abstract/irepository.dart';
import 'package:insta_following/ui/theme/themes/white/white_theme_utils.dart';

class PostView extends StatefulWidget {
  PostView({Key key, @required this.viewName}) : super(key: key);
  final String viewName;

  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
     _PostViewState():
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
       body: Container(),
    );
  }
}