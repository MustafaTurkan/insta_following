import 'package:dio/dio.dart';
import 'package:insta_following/helpers/app_context.dart';
import 'package:insta_following/helpers/logger/logger.dart';
import 'package:insta_following/services/instagram_api_service.dart';

class FakeInstagramApiService extends InstagramApiService {
  FakeInstagramApiService(AppContext appContext, Logger logger) : super(appContext, logger);

  @override
  void initialize() {
    super.initialize();
    dio.interceptors.add(FakeDataInterceptor(dio));
  }
}

class FakeDataInterceptor extends InterceptorsWrapper {
  FakeDataInterceptor(this.dio);

  final Dio dio;

  @override
  Future<dynamic> onRequest(RequestOptions options) async {
    await Future.delayed(Duration(milliseconds: 1000), () => null);

    if (options.path.contains('/oauth/access_token')) {
      return dio.resolve<String>(FakeDataInstagramService.authenticate());
    }

    if (options.path.contains('insta/profile')) {
      return dio.resolve<String>(FakeDataInstagramService.getProfile());
    }

    if (options.path.contains('/insta/menu-contents')) {
      return dio.resolve<String>(FakeDataInstagramService.getMenuContent());
    }

    if (options.path.contains('/insta/earned-followers')) {
      return dio.resolve<String>(FakeDataInstagramService.getFollowers());
    }

   if (options.path.contains('/insta/followers-not-following')) {
      return dio.resolve<String>(FakeDataInstagramService.getFollowers());
    }
    
      if (options.path.contains('/insta/fans')) {
      return dio.resolve<String>(FakeDataInstagramService.getFollowers());
    }

          if (options.path.contains('/insta/friends')) {
      return dio.resolve<String>(FakeDataInstagramService.getFollowers());
    }

    
    if (options.path.contains('/insta/lost-followers')) {
      return dio.resolve<String>(FakeDataInstagramService.getFollowers());
    }

    return dio.resolve<String>('FakeData class not configured for this path:${options.path}');
  }
}

class FakeDataInstagramService {
  FakeDataInstagramService._();

  static String authenticate() {
    return '''{"access_token":"123","user_id":123321}''';
  }

  static String getProfile() {
    return '''{"userName":"mustafaTurka","firstName":"Mustafa","lastName":"TÜRKAN","imageUrl":"https://images.unsplash.com/photo-1521572267360-ee0c2909d518?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80","followedCount":220,"followersCount":202,"avglike":86,"postCount":3,"avgComment":5}''';
  }

  static String getMenuContent() {
    return '''[
{"name":"earnedFollowers","count":12,"urlFirst":"https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80","urlSecond":"https://images.unsplash.com/photo-1474447976065-67d23accb1e3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=332&q=80","urlTird":"https://images.unsplash.com/photo-1455274111113-575d080ce8cd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80"},
{"name":"followersNotFollowing","count":26,"urlFirst":"https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80","urlSecond":"https://images.unsplash.com/photo-1474447976065-67d23accb1e3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=332&q=80","urlTird":"https://images.unsplash.com/photo-1455274111113-575d080ce8cd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80"},
{"name":"fans","count":4,"urlFirst":"https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80","urlSecond":"https://images.unsplash.com/photo-1474447976065-67d23accb1e3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=332&q=80","urlTird":"https://images.unsplash.com/photo-1455274111113-575d080ce8cd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80"},
{"name":"friends","count":180,"urlFirst":"https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80","urlSecond":"https://images.unsplash.com/photo-1474447976065-67d23accb1e3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=332&q=80","urlTird":"https://images.unsplash.com/photo-1455274111113-575d080ce8cd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80"},
{"name":"lostFollowers","count":18,"urlFirst":"https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80","urlSecond":"https://images.unsplash.com/photo-1474447976065-67d23accb1e3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=332&q=80","urlTird":"https://images.unsplash.com/photo-1455274111113-575d080ce8cd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80"},
{"name":"audience","count":86,"urlFirst":"https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80","urlSecond":"https://images.unsplash.com/photo-1474447976065-67d23accb1e3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=332&q=80","urlTird":"https://images.unsplash.com/photo-1455274111113-575d080ce8cd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80"},
{"name":"mostCommentedPost","count":null,"urlFirst":"https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80","urlSecond":"https://images.unsplash.com/photo-1474447976065-67d23accb1e3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=332&q=80","urlTird":"https://images.unsplash.com/photo-1455274111113-575d080ce8cd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80"},
{"name":"mostLikedPost","count":null,"urlFirst":"https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80","urlSecond":"https://images.unsplash.com/photo-1474447976065-67d23accb1e3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=332&q=80","urlTird":"https://images.unsplash.com/photo-1455274111113-575d080ce8cd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80"},
{"name":"lessCommentedPost","count":null,"urlFirst":"https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80","urlSecond":"https://images.unsplash.com/photo-1474447976065-67d23accb1e3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=332&q=80","urlTird":"https://images.unsplash.com/photo-1455274111113-575d080ce8cd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80"},
{"name":"lessLikedPost","count":null,"urlFirst":"https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80","urlSecond":"https://images.unsplash.com/photo-1474447976065-67d23accb1e3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=332&q=80","urlTird":"https://images.unsplash.com/photo-1455274111113-575d080ce8cd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80"} 
    ]''';
  }

static String getFollowers()
{
 return '''[
{"name":"edo_uykn","firstName":"Edibe","lastName":"Uyanık","profileUrl":"https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80","isFollow":1},
{"name":"m.chruk","firstName":"Mehmet","lastName":"Çürük","profileUrl":"https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=80","isFollow":1}, 
{"name":"gkon","firstName":"Gökberk","lastName":"Konuralp","profileUrl":"https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=889&q=80","isFollow":1}, 
{"name":"mertokin","firstName":"Mert","lastName":"Tekin","profileUrl":"https://images.unsplash.com/photo-1497316730643-415fac54a2af?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=80","isFollow":0},
{"name":"murtaz","firstName":"Murtazali","lastName":"Uyanık","profileUrl":"https://images.unsplash.com/photo-1457449940276-e8deed18bfff?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80","isFollow":1},
{"name":"muratsoylu42","firstName":"Murat","lastName":"Soylu","profileUrl":"https://images.unsplash.com/photo-1466112928291-0903b80a9466?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=753&q=80","isFollow":0},
{"name":"ayshe_ylmn","firstName":"Ayşe","lastName":"Yılman","profileUrl":"https://images.unsplash.com/photo-1474552226712-ac0f0961a954?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=751&q=80","isFollow":1},
{"name":"isyankar_sinoplu","firstName":"Uğur","lastName":"Çaylı","profileUrl":"https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80","isFollow":0},
{"name":"yargıc_müco","firstName":"Mücadiye","lastName":"Uyanık","profileUrl":"https://images.unsplash.com/photo-1532074205216-d0e1f4b87368?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=381&q=80","isFollow":1},
{"name":"ugr_erdal","firstName":"Uğur","lastName":"Erdal","profileUrl":"https://images.unsplash.com/photo-1520592978680-efbdeae5d036?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80","isFollow":1},
{"name":"cüno_fake","firstName":"Cüneyt","lastName":"Yılmaz","profileUrl":"https://images.unsplash.com/photo-1522778147829-047360bdc7f6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=358&q=80","isFollow":1},
{"name":"single_tread","firstName":"Mustafa","lastName":"Büyükçelebi","profileUrl":"https://images.unsplash.com/photo-1502764088999-001291e403de?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=941&q=80","isFollow":1},
{"name":"veli_gokce","firstName":"Veli","lastName":"Gökçe","profileUrl":"https://images.unsplash.com/photo-1517070208541-6ddc4d3efbcb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80","isFollow":1},
{"name":"el_buruni","firstName":"İlimdar","lastName":"Aydın","profileUrl":"https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=80","isFollow":0},
{"name":"dilara_soylu","firstName":"Dilara","lastName":"Soylu","profileUrl":"https://images.unsplash.com/photo-1520155707862-5b32817388d6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80","isFollow":1},
{"name":"ftmYlman","firstName":"Fatma","lastName":"Yılman","profileUrl":"https://images.unsplash.com/photo-1474978528675-4a50a4508dc3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80","isFollow":1},
{"name":"rojhat_kurdi","firstName":"Rojhat Ali","lastName":"Aydın","profileUrl":"https://images.unsplash.com/photo-1536164261511-3a17e671d380?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=330&q=80","isFollow":1},
{"name":"edo_uykn","firstName":"Edibe","lastName":"Uyanık","profileUrl":"https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80","isFollow":1},
{"name":"m.chruk","firstName":"Mehmet","lastName":"Çürük","profileUrl":"https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=80","isFollow":1}, 
{"name":"gkon","firstName":"Gökberk","lastName":"Konuralp","profileUrl":"https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=889&q=80","isFollow":1}, 
{"name":"mertokin","firstName":"Mert","lastName":"Tekin","profileUrl":"https://images.unsplash.com/photo-1497316730643-415fac54a2af?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=80","isFollow":0},
{"name":"murtaz","firstName":"Murtazali","lastName":"Uyanık","profileUrl":"https://images.unsplash.com/photo-1457449940276-e8deed18bfff?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80","isFollow":1},
{"name":"muratsoylu42","firstName":"Murat","lastName":"Soylu","profileUrl":"https://images.unsplash.com/photo-1466112928291-0903b80a9466?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=753&q=80","isFollow":0},
{"name":"ayshe_ylmn","firstName":"Ayşe","lastName":"Yılman","profileUrl":"https://images.unsplash.com/photo-1474552226712-ac0f0961a954?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=751&q=80","isFollow":1},
{"name":"isyankar_sinoplu","firstName":"Uğur","lastName":"Çaylı","profileUrl":"https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80","isFollow":0},
{"name":"yargıc_müco","firstName":"Mücadiye","lastName":"Uyanık","profileUrl":"https://images.unsplash.com/photo-1532074205216-d0e1f4b87368?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=381&q=80","isFollow":1},
{"name":"ugr_erdal","firstName":"Uğur","lastName":"Erdal","profileUrl":"https://images.unsplash.com/photo-1520592978680-efbdeae5d036?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80","isFollow":1},
{"name":"cüno_fake","firstName":"Cüneyt","lastName":"Yılmaz","profileUrl":"https://images.unsplash.com/photo-1522778147829-047360bdc7f6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=358&q=80","isFollow":1},
{"name":"single_tread","firstName":"Mustafa","lastName":"Büyükçelebi","profileUrl":"https://images.unsplash.com/photo-1502764088999-001291e403de?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=941&q=80","isFollow":1},
{"name":"veli_gokce","firstName":"Veli","lastName":"Gökçe","profileUrl":"https://images.unsplash.com/photo-1517070208541-6ddc4d3efbcb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80","isFollow":1},
{"name":"el_buruni","firstName":"İlimdar","lastName":"Aydın","profileUrl":"https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=80","isFollow":0},
{"name":"dilara_soylu","firstName":"Dilara","lastName":"Soylu","profileUrl":"https://images.unsplash.com/photo-1520155707862-5b32817388d6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80","isFollow":1},
{"name":"ftmYlman","firstName":"Fatma","lastName":"Yılman","profileUrl":"https://images.unsplash.com/photo-1474978528675-4a50a4508dc3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80","isFollow":1},
{"name":"rojhat_kurdi","firstName":"Rojhat Ali","lastName":"Aydın","profileUrl":"https://images.unsplash.com/photo-1536164261511-3a17e671d380?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=330&q=80","isFollow":1},
{"name":"edo_uykn","firstName":"Edibe","lastName":"Uyanık","profileUrl":"https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80","isFollow":1},
{"name":"m.chruk","firstName":"Mehmet","lastName":"Çürük","profileUrl":"https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=80","isFollow":1}, 
{"name":"gkon","firstName":"Gökberk","lastName":"Konuralp","profileUrl":"https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=889&q=80","isFollow":1}, 
{"name":"mertokin","firstName":"Mert","lastName":"Tekin","profileUrl":"https://images.unsplash.com/photo-1497316730643-415fac54a2af?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=80","isFollow":0},
{"name":"murtaz","firstName":"Murtazali","lastName":"Uyanık","profileUrl":"https://images.unsplash.com/photo-1457449940276-e8deed18bfff?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80","isFollow":1},
{"name":"muratsoylu42","firstName":"Murat","lastName":"Soylu","profileUrl":"https://images.unsplash.com/photo-1466112928291-0903b80a9466?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=753&q=80","isFollow":0},
{"name":"ayshe_ylmn","firstName":"Ayşe","lastName":"Yılman","profileUrl":"https://images.unsplash.com/photo-1474552226712-ac0f0961a954?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=751&q=80","isFollow":1},
{"name":"isyankar_sinoplu","firstName":"Uğur","lastName":"Çaylı","profileUrl":"https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80","isFollow":0},
{"name":"yargıc_müco","firstName":"Mücadiye","lastName":"Uyanık","profileUrl":"https://images.unsplash.com/photo-1532074205216-d0e1f4b87368?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=381&q=80","isFollow":1},
{"name":"ugr_erdal","firstName":"Uğur","lastName":"Erdal","profileUrl":"https://images.unsplash.com/photo-1520592978680-efbdeae5d036?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80","isFollow":1},
{"name":"cüno_fake","firstName":"Cüneyt","lastName":"Yılmaz","profileUrl":"https://images.unsplash.com/photo-1522778147829-047360bdc7f6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=358&q=80","isFollow":1},
{"name":"single_tread","firstName":"Mustafa","lastName":"Büyükçelebi","profileUrl":"https://images.unsplash.com/photo-1502764088999-001291e403de?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=941&q=80","isFollow":1},
{"name":"veli_gokce","firstName":"Veli","lastName":"Gökçe","profileUrl":"https://images.unsplash.com/photo-1517070208541-6ddc4d3efbcb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80","isFollow":1},
{"name":"el_buruni","firstName":"İlimdar","lastName":"Aydın","profileUrl":"https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=80","isFollow":0},
{"name":"dilara_soylu","firstName":"Dilara","lastName":"Soylu","profileUrl":"https://images.unsplash.com/photo-1520155707862-5b32817388d6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80","isFollow":1},
{"name":"ftmYlman","firstName":"Fatma","lastName":"Yılman","profileUrl":"https://images.unsplash.com/photo-1474978528675-4a50a4508dc3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80","isFollow":1},
{"name":"rojhat_kurdi","firstName":"Rojhat Ali","lastName":"Aydın","profileUrl":"https://images.unsplash.com/photo-1536164261511-3a17e671d380?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=330&q=80","isFollow":1},
{"name":"edo_uykn","firstName":"Edibe","lastName":"Uyanık","profileUrl":"https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80","isFollow":1},
{"name":"m.chruk","firstName":"Mehmet","lastName":"Çürük","profileUrl":"https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=80","isFollow":1}, 
{"name":"gkon","firstName":"Gökberk","lastName":"Konuralp","profileUrl":"https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=889&q=80","isFollow":1}, 
{"name":"mertokin","firstName":"Mert","lastName":"Tekin","profileUrl":"https://images.unsplash.com/photo-1497316730643-415fac54a2af?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=80","isFollow":0},
{"name":"murtaz","firstName":"Murtazali","lastName":"Uyanık","profileUrl":"https://images.unsplash.com/photo-1457449940276-e8deed18bfff?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80","isFollow":1},
{"name":"muratsoylu42","firstName":"Murat","lastName":"Soylu","profileUrl":"https://images.unsplash.com/photo-1466112928291-0903b80a9466?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=753&q=80","isFollow":0},
{"name":"ayshe_ylmn","firstName":"Ayşe","lastName":"Yılman","profileUrl":"https://images.unsplash.com/photo-1474552226712-ac0f0961a954?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=751&q=80","isFollow":1},
{"name":"isyankar_sinoplu","firstName":"Uğur","lastName":"Çaylı","profileUrl":"https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80","isFollow":0},
{"name":"yargıc_müco","firstName":"Mücadiye","lastName":"Uyanık","profileUrl":"https://images.unsplash.com/photo-1532074205216-d0e1f4b87368?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=381&q=80","isFollow":1},
{"name":"ugr_erdal","firstName":"Uğur","lastName":"Erdal","profileUrl":"https://images.unsplash.com/photo-1520592978680-efbdeae5d036?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80","isFollow":1},
{"name":"cüno_fake","firstName":"Cüneyt","lastName":"Yılmaz","profileUrl":"https://images.unsplash.com/photo-1522778147829-047360bdc7f6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=358&q=80","isFollow":1},
{"name":"single_tread","firstName":"Mustafa","lastName":"Büyükçelebi","profileUrl":"https://images.unsplash.com/photo-1502764088999-001291e403de?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=941&q=80","isFollow":1},
{"name":"veli_gokce","firstName":"Veli","lastName":"Gökçe","profileUrl":"https://images.unsplash.com/photo-1517070208541-6ddc4d3efbcb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80","isFollow":1},
{"name":"el_buruni","firstName":"İlimdar","lastName":"Aydın","profileUrl":"https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=80","isFollow":0},
{"name":"dilara_soylu","firstName":"Dilara","lastName":"Soylu","profileUrl":"https://images.unsplash.com/photo-1520155707862-5b32817388d6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80","isFollow":1},
{"name":"ftmYlman","firstName":"Fatma","lastName":"Yılman","profileUrl":"https://images.unsplash.com/photo-1474978528675-4a50a4508dc3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80","isFollow":1},
{"name":"rojhat_kurdi","firstName":"Rojhat Ali","lastName":"Aydın","profileUrl":"https://images.unsplash.com/photo-1536164261511-3a17e671d380?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=330&q=80","isFollow":1},
]''';
  }
  
}




