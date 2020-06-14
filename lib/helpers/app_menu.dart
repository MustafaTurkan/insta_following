import 'package:insta_following/helpers/app_string.dart';

class AppMenu
{
  static  bool isFriendsMenuItem(String menuName) {
    if (AppString.earnedFollowers.contains(menuName) ||
        AppString.followersNotFollowing.contains(menuName) ||
        AppString.fans.contains(menuName) ||
        AppString.friends.contains(menuName) ||
        AppString.lostFollowers.contains(menuName) ||
        AppString.audience.contains(menuName)) {
      return true;
    }
    return false;
  }

 static bool isPostsMenuItem(String menuName) {
    if (AppString.mostCommentedPost.contains(menuName) ||
        AppString.mostLikedPost.contains(menuName) ||
        AppString.lessCommentedPost.contains(menuName) ||
        AppString.lessLikedPost.contains(menuName)) {
      return true;
    }
    return false;
  }

}