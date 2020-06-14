import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:insta_following/helpers/app_string.dart';
import 'package:insta_following/helpers/error/app_exception.dart';
import 'package:insta_following/helpers/logger/logger.dart';
import 'package:insta_following/models/friend.dart';
import 'package:insta_following/repositories/abstract/irepository.dart';
import 'package:meta/meta.dart';
import 'package:insta_following/helpers/extensions/iterable_extensions.dart';
part 'friend_event.dart';
part 'friend_state.dart';

class FriendBloc extends Bloc<FriendEvent, FriendState> {
  FriendBloc({@required this.logger, @required this.repository}) : assert(logger != null);

  final Logger logger;
  final IRepository repository;

  List<Friend> _audiences;
  List<Friend> _earnedFollowers;
  List<Friend> _fans;
  List<Friend> _followersNotFollowings;
  List<Friend> _friends;
  List<Friend> _lostFollowers;

  @override
  FriendState get initialState => FriendInitial();

  @override
  Stream<FriendState> mapEventToState(
    FriendEvent event,
  ) async* {
    if (event is OnLoadFriend) {
      yield* _mapFriendLoad(event);
    }
  }

  Stream<FriendState> _mapFriendLoad(OnLoadFriend event) async* {
    try {
      yield FriendLoading();

      List<Friend> result;
      if (AppString.audience.contains(event.menuName)) {
        if (_audiences.isNullOrEmpty()) {
          _audiences = await repository.getAudience();
        }
        result = _audiences;
      } else if (AppString.earnedFollowers.contains(event.menuName)) {
        if (_earnedFollowers.isNullOrEmpty()) {
          _earnedFollowers = await repository.getEarnedFollowers();
        }
        result = _earnedFollowers;
      } else if (AppString.fans.contains(event.menuName)) {
        if (_fans.isNullOrEmpty()) {
          _fans = await repository.getFans();
        }
        result = _fans;
      } else if (AppString.followersNotFollowing.contains(event.menuName)) {
        if (_followersNotFollowings.isNullOrEmpty()) {
          _followersNotFollowings = await repository.getFollowersNotFollowing();
        }
        result = _followersNotFollowings;
      } else if (AppString.friends.contains(event.menuName)) {
        if (_friends.isNullOrEmpty()) {
          _friends = await repository.getFriends();
        }
        result = _friends;
      } else if (AppString.lostFollowers.contains(event.menuName)) {
        if (_lostFollowers.isNullOrEmpty()) {
          _lostFollowers = await repository.getFriends();
        }
        result = _lostFollowers;
      }

      if (result == null) {
        yield FriendFail(reason: AppString.nullResultFriend);
      } else {
        yield FriendLoadSuccess(friends: result);
      }
    } on AppException catch (e) {
      yield FriendFail(reason: e.message);
      logger.error(e);
    } catch (e) {
      yield FriendFail(reason: AppString.unExpectedErrorOccurred);
      logger.error(e);
    }
  }
}
