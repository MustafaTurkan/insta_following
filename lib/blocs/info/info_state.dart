part of 'info_bloc.dart';

@immutable
abstract class InfoState {}

class InfoInitial extends InfoState {}

class InfoLoading extends InfoState{}

class InfoLoadSuccess extends InfoState{
  InfoLoadSuccess({this.profile, this.menu});
  final Profile profile;
  final List<MenuContent> menu;
}

class InfoFail extends InfoState{
  InfoFail({@required this.reason});
  final String reason;
  @override
  String toString() => 'LoginFail { reason: $reason }';
}



