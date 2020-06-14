class Enum {
  static String getName(dynamic enumItem) {
    if (enumItem == null) {
      return null;
    }
    return enumItem.toString().split('.').last;
  }
}
enum Menu{
  earnedFollowers,
  followersNotFollowing,
  fans,
  friends,
  lostFollowers,
  audience,
  mostcommentedPost,
  mostLikedPost,
  lessCommentedPost,
  lessLikedPost
}
