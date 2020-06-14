import 'package:insta_following/models/authentication_token.dart';
import 'package:insta_following/models/friend.dart';
import 'package:insta_following/models/menu_content.dart';
import 'package:insta_following/models/profile.dart';

abstract class IRepository {
  Future<AuthenticationToken> authenticate(String code);
  Future<bool> healtCheck();
  Future<Profile> getProfileInfo();
  Future<List<MenuContent>> getMenuInfo();
  Future<List<Friend>> getEarnedFollowers();
  Future<List<Friend>> getFollowersNotFollowing();
  Future<List<Friend>> getFans();
  Future<List<Friend>> getFriends();
  Future<List<Friend>> getLostFollowers();
  Future<List<Friend>> getAudience();
}
