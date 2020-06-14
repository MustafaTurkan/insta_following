

import 'package:insta_following/helpers/utils/type.dart';


extension DateTimeExtensions on DateTime {
  bool isEmpty() => this == null || year == DefaultValues.dateTimeValue.year;
  DateTime orDefault() => this ?? DefaultValues.dateTimeValue;
}
