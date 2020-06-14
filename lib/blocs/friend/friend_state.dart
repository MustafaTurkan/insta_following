part of 'friend_bloc.dart';

@immutable
abstract class FriendState {}

class FriendInitial extends FriendState {}

class FriendLoading extends FriendState{}

class FriendLoadSuccess extends FriendState{
  FriendLoadSuccess({this.friends});
  final List<Friend> friends;
}

class FriendFail extends FriendState{
  FriendFail({@required this.reason});
  final String reason;
  @override
  String toString() => 'LoginFail { reason: $reason }';
}
