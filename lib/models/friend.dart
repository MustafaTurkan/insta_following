import 'package:insta_following/helpers/extensions/map_extensions.dart';

class Friend {
  Friend({this.name,this.firstName, this.isFollow, this.lastName, this.profileUrl});

  Friend.fromJson(Map<String, dynamic> json) {
    firstName = json.getValue<String>('firstName');
    lastName = json.getValue<String>('lastName');
    isFollow = json.getValue<bool>('isFollow');
    profileUrl = json.getValue<String>('profileUrl');
     name = json.getValue<String>('name');
  }

  String firstName;
  bool isFollow;
  String lastName;
  String name;
  String profileUrl;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['isFollow'] = isFollow;
    data['profileUrl'] = profileUrl;
      data['name'] = name;
    return data;
  }
}
