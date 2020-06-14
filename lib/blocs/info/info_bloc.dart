import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:insta_following/helpers/app_string.dart';
import 'package:insta_following/helpers/error/app_exception.dart';
import 'package:insta_following/helpers/logger/logger.dart';
import 'package:insta_following/models/menu_content.dart';
import 'package:insta_following/models/profile.dart';
import 'package:insta_following/repositories/abstract/irepository.dart';
import 'package:meta/meta.dart';

part 'info_event.dart';
part 'info_state.dart';

class InfoBloc extends Bloc<InfoEvent, InfoState> {
  InfoBloc({@required this.logger,@required this.repository}) : assert(logger != null);

  final Logger logger;
  final IRepository repository;

  @override
  InfoState get initialState => InfoInitial();

  @override
  Stream<InfoState> mapEventToState(
    InfoEvent event,
  ) async* {
    if (event is OnInfoLoad) {
      yield* _mapInfoLoad();
    }
  }

  Stream<InfoState> _mapInfoLoad() async* {
    try {
      yield InfoLoading();
      var profile= await repository.getProfileInfo();
      var menu=await repository.getMenuInfo();
      
      if(profile==null||menu==null)
      {
        yield InfoFail(reason:AppString.nullResultInfo);
      }
      else
      {
        yield InfoLoadSuccess(
          menu: menu,
          profile: profile
        );
      }
          
    
 
    } on AppException catch (e) {
      yield InfoFail(reason: e.message);
      logger.error(e);
    } catch (e) {
      yield InfoFail(reason: AppString.unExpectedErrorOccurred);
      logger.error(e);
    }
  }
}
