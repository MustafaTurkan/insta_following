import 'package:insta_following/models/authentication_token.dart';
import 'package:insta_following/models/friend.dart';
import 'package:insta_following/models/menu_content.dart';
import 'package:insta_following/models/profile.dart';
import 'package:insta_following/repositories/abstract/irepository.dart';
import 'package:insta_following/services/instagram_api_service.dart';

class AppRepository extends IRepository {
  AppRepository(this.apiClient);
  InstagramApiService apiClient;

  @override
  Future<AuthenticationToken> authenticate(String code) async {
    apiClient.initialize();
    return apiClient.authenticate(code);
  }

  @override
  Future<bool> healtCheck() async {
    return apiClient.healtCheck();
  }

  @override
  Future<List<MenuContent>> getMenuInfo() async {
    return apiClient.getMenuContents();
  }

  @override
  Future<Profile> getProfileInfo() async {
    return apiClient.getProfile();
  }

  @override
  Future<List<Friend>> getAudience() async {
    return apiClient.getAudience();
  }

  @override
  Future<List<Friend>> getEarnedFollowers() async {
    return apiClient.getEarnedFollowers();
  }

  @override
  Future<List<Friend>> getFans() async {
    return apiClient.getFans();
  }

  @override
  Future<List<Friend>> getFollowersNotFollowing() async {
    return apiClient.getFollowersNotFollowing();
  }

  @override
  Future<List<Friend>> getFriends() async {
    return apiClient.getFriends();
  }

  @override
  Future<List<Friend>> getLostFollowers() async {
    return apiClient.getLostFollowers();
  }
}
