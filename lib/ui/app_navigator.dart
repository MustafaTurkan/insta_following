import 'package:flutter/material.dart';
import 'package:insta_following/helpers/app_menu.dart';
import 'package:insta_following/ui/views/friends_view.dart';
import 'package:insta_following/ui/views/home_view.dart';
import 'package:insta_following/ui/views/login_view.dart';
import 'package:insta_following/ui/views/posts_view.dart';



class AppNavigator{
  static final key = GlobalKey<NavigatorState>();
  static final routeObserver = RouteObserver<PageRoute>();


  void pushLoginClearHistory(BuildContext context) {
    Navigator.of(context)
        .pushAndRemoveUntil<dynamic>(MaterialPageRoute<dynamic>(builder: (context) => LoginView()), (route) => false);
  }

  void pushHomeClearHistory(BuildContext context) {
    Navigator.of(context)
        .pushAndRemoveUntil<dynamic>(MaterialPageRoute<dynamic>(builder: (context) => HomeView()), (route) => false);
  }

  void pushHome(BuildContext context) {
    Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(builder: (context) => HomeView()));
  }

  void pushFriends(BuildContext context,{String viewName}) {
    Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(builder: (context) => FriendsView(viewName: viewName)));
  }
  void pushPosts(BuildContext context,{String viewName}) {
    Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(builder: (context) => PostView(viewName: viewName)));
  }

  void pushMenu(String menuName,BuildContext context) {
    if (AppMenu.isFriendsMenuItem(menuName)) {
       pushFriends(context, viewName: menuName);
    } else if (AppMenu.isPostsMenuItem(menuName)) {
       pushPosts(context, viewName: menuName);
    }
  }
  

  void pop<T extends Object>(BuildContext context, {T result}) {
    Navigator.of(context).pop<T>(result);
  }
}
