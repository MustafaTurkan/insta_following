import 'package:insta_following/helpers/extensions/map_extensions.dart';

class Profile {
  Profile(
      {this.imageUrl,
      this.userName,
      this.postCount,
      this.avgComment,
      this.avglike,
      this.firstName,
      this.followedCount,
      this.followersCount,
      this.lastName});

  Profile.fromJson(Map<String, dynamic> json) {
    userName = json.getValue<String>('userName');
    firstName = json.getValue<String>('firstName');
    lastName = json.getValue<String>('lastName');
    imageUrl = json.getValue<String>('imageUrl');
    followedCount = json.getValue<int>('followedCount');
    followersCount = json.getValue<int>('followersCount');
    avglike = json.getValue<int>('avglike');
    postCount = json.getValue<int>('postCount');
    avgComment = json.getValue<int>('avgComment');
  }

  String userName;
  String firstName;
  String lastName;
  String imageUrl;
  int followedCount;
  int followersCount;
  int avglike;
  int postCount;
  int avgComment;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['imageUrl'] = imageUrl;
    data['followedCount'] = followedCount;
    data['followersCount'] = followersCount;
    data['postCount'] = postCount;
    data['avgComment'] = avgComment;

    return data;
  }
}
