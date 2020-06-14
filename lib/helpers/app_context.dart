

import 'package:insta_following/models/authentication_token.dart';

class AppContext {
  AuthenticationToken _token;
  AuthenticationToken get token {
    return _token;
  }

  set registerAppToken(
    AuthenticationToken authToken,
  ) {
    _token = authToken;
  }
}
