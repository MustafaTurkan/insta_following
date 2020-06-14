
import 'package:insta_following/helpers/extensions/map_extensions.dart';

class AuthenticationToken {
  AuthenticationToken({this.accessToken, this.userId});

  AuthenticationToken.fromJson(Map<String, dynamic> json) {
    accessToken = json.getValue<String>('access_token');
    userId = json.getValue<int>('user_id');
  }
  
  String accessToken;
  int userId;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['user_id'] = userId;
    return data;
  }
}


