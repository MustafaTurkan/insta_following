part of 'friend_bloc.dart';

@immutable
abstract class FriendEvent {}

class OnLoadFriend extends FriendEvent{
  OnLoadFriend({@required this.menuName});
  final String menuName;
}
