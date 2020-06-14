import 'package:insta_following/helpers/extensions/map_extensions.dart';

class MenuContent {
  MenuContent({this.count, this.name, this.urlFirst, this.urlSecond, this.urlTird});

  MenuContent.fromJson(Map<String, dynamic> json) {
    name = json.getValue<String>('name');
    count = json.getValue<int>('count');
    urlFirst = json.getValue<String>('urlFirst');
    urlSecond = json.getValue<String>('urlSecond');
    urlTird = json.getValue<String>('urlTird');
  }

  String name;
  int count;
  String urlFirst;
  String urlSecond;
  String urlTird;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['count'] = count;
    data['urlFirst'] = urlFirst;
    data['urlSecond'] = urlSecond;
    data['urlTird'] = urlTird;
    return data;
  }
}
