import 'dart:async';
import 'package:flutter/material.dart';
import 'package:insta_following/helpers/app_string.dart';
import 'package:intl/intl.dart';
import 'locales/messages_all.dart';

class Localizer {
  // workaroud for contextless translation
  //see https://github.com/flutter/flutter/issues/14518#issuecomment-447481671
  static Localizer instance;

  static Future<Localizer> load(Locale locale) {
    final String name = locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      instance = Localizer();
      return instance;
    });
  }

  static Localizer of(BuildContext context) {
    return Localizations.of<Localizer>(context, Localizer);
  }

  String get appName => Intl.message(AppString.appName);
  String get loginContract => Intl.message(AppString.loginContract);
  String get loginHeader => Intl.message(AppString.loginHeader);
  String get loginInformation => Intl.message(AppString.loginInformation);
  String get loginWithInstagram => Intl.message(AppString.loginWithInstagram);
  String get unExpectedErrorOccurred => Intl.message(AppString.unExpectedErrorOccurred);
  String get nullResultAuthentication => Intl.message(AppString.nullResultAuthentication);
  
  String get followers => Intl.message(AppString.followers);
  String get following => Intl.message(AppString.following);
  String get averageLikes => Intl.message(AppString.averageLikes);
  String get posts => Intl.message(AppString.posts);
  String get averageComment => Intl.message(AppString.averageComment);
  String get earnedFollowers => Intl.message(AppString.earnedFollowers);
  String get followersNotFollowing => Intl.message(AppString.followersNotFollowing);
  String get fans => Intl.message(AppString.fans);
  String get friends => Intl.message(AppString.friends);
  String get lostFollowers => Intl.message(AppString.lostFollowers);
  String get audience => Intl.message(AppString.audience);
  String get mostcommentedPost => Intl.message(AppString.mostCommentedPost);
  String get mostLikedPost => Intl.message(AppString.mostLikedPost);
  String get lessCommentedPost => Intl.message(AppString.lessCommentedPost);
  String get lessLikedPost => Intl.message(AppString.lessLikedPost);
  String get follow => Intl.message(AppString.follow);
  String get unfollow => Intl.message(AppString.unfollow);
  String get ok => Intl.message(AppString.ok);
  String get yes => Intl.message(AppString.yes);
    String get no => Intl.message(AppString.no);
  String get cancel => Intl.message(AppString.cancel);
    String get warning => Intl.message(AppString.warning);
  String get error => Intl.message(AppString.error);
    String get information => Intl.message(AppString.information);
  String get question => Intl.message(AppString.question);
    String get message => Intl.message(AppString.message);
  String get loading => Intl.message(AppString.loading);

  //dynamic text translate
  String translate(String text,
      {String desc = '',
      Map<String, Object> examples = const {},
      String locale,
      String name,
      List<Object> args,
      String meaning,
      bool skip}) {
    return Intl.message(text,
        desc: desc, examples: examples, locale: locale, name: name, args: args, meaning: meaning, skip: skip);
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<Localizer> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'tr'].contains(locale.languageCode);
  }

  @override
  Future<Localizer> load(Locale locale) {
    return Localizer.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<Localizer> old) {
    return false;
  }
}
