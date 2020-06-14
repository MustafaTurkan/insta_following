import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:insta_following/helpers/app_constants.dart';
import 'dart:convert';
import 'package:insta_following/helpers/app_context.dart';
import 'package:insta_following/helpers/app_string.dart';
import 'package:insta_following/helpers/error/app_error.dart';
import 'package:insta_following/helpers/error/app_exception.dart';
import 'package:insta_following/helpers/logger/logger.dart';
import 'package:insta_following/models/authentication_token.dart';
import 'package:insta_following/models/error_model.dart';
import 'package:insta_following/models/friend.dart';
import 'package:insta_following/models/menu_content.dart';
import 'package:insta_following/models/profile.dart';

class InstagramApiService {
  InstagramApiService(this.appContext, this.logger);

  final AppContext appContext;
  final Logger logger;

  Dio dio;

  Options get _requestOptions {
    return Options(headers: <String, dynamic>{'Authorization': 'Bearer $_authorizationToken'});
  }

  String get _authorizationToken {
    _validateInitialized();
    return appContext.token.accessToken;
  }

  void initialize() {
    dio ??= Dio();
    dio.options.baseUrl = AppConstants.baseUrl;
    dio.options.responseType = ResponseType.json;
    dio.options.contentType = Headers.formUrlEncodedContentType;
    dio.options.connectTimeout = 30 * 1000;
    dio.options.receiveTimeout = 30 * 1000;

    var transformer = dio.transformer as DefaultTransformer;
    transformer.jsonDecodeCallback = jsonDecodeAsync;

    if (!kReleaseMode) {
      dio.interceptors.add(LogInterceptor());
    }
  }

  void _validateInitialized() {
    dio ??= throw AppError('V3StoreApi not initialized!');
  }

  Future<bool> healtCheck() async {
    try {
      final response = await dio.get<dynamic>('health-check');
      return response.statusCode == HttpStatus.accepted;
    } catch (e) {
      throw ApiException.fromError(e);
    }
  }

  static dynamic _jsonDecodeCallback(String data) => json.decode(data);

  static Future<dynamic> jsonDecodeAsync(String data) {
    return compute<String, dynamic>(_jsonDecodeCallback, data);
  }

  Future<AuthenticationToken> authenticate(String code) async {
    try {
      final response = await dio.post<String>(
        '/oauth/access_token',
        data: <String, dynamic>{
          'client_id': AppConstants.appId,
          'redirect_uri': AppConstants.redirectUri,
          'client_secret': AppConstants.appSecret,
          'code': code,
          'grant_type': 'authorization_code',
        },
      );
      return AuthenticationToken.fromJson(await jsonDecodeAsync(response.data) as Map<String, dynamic>);
    } catch (e) {
      throw ApiException.fromError(e);
    }
  }

  Future<Profile> getProfile() async {
    try {
      final response = await dio.get<String>('insta/profile',
          queryParameters: <String, dynamic>{
            'accessToken': appContext.token.accessToken,
            'userId': appContext.token.userId,
          },
          options: _requestOptions);
      return Profile.fromJson(await jsonDecodeAsync(response.data) as Map<String, dynamic>);
    } catch (e) {
      throw ApiException.fromError(e);
    }
  }

  Future<List<MenuContent>> getMenuContents() async {
    try {
      final response = await dio.get<String>(
        '/insta/menu-contents',
        options: _requestOptions,
      );
      final list = await jsonDecodeAsync(response.data) as List<dynamic>;
      return list.map<MenuContent>((dynamic model) => MenuContent.fromJson(model as Map<String, dynamic>)).toList();
    } catch (e) {
      throw ApiException.fromError(e);
    }
  }

  Future<List<Friend>> getEarnedFollowers() async {
    try {
      final response = await dio.get<String>(
        '/insta/earned-followers',
        options: _requestOptions,
      );
      final list = await jsonDecodeAsync(response.data) as List<dynamic>;
      return list.map<Friend>((dynamic model) => Friend.fromJson(model as Map<String, dynamic>)).toList();
    } catch (e) {
      throw ApiException.fromError(e);
    }
  }

  Future<List<Friend>> getFollowersNotFollowing() async {
    try {
      final response = await dio.get<String>(
        '/insta/followers-not-following',
        options: _requestOptions,
      );
      final list = await jsonDecodeAsync(response.data) as List<dynamic>;
      return list.map<Friend>((dynamic model) => Friend.fromJson(model as Map<String, dynamic>)).toList();
    } catch (e) {
      throw ApiException.fromError(e);
    }
  }

  Future<List<Friend>> getFans() async {
    try {
      final response = await dio.get<String>(
        '/insta/fans',
        options: _requestOptions,
      );
      final list = await jsonDecodeAsync(response.data) as List<dynamic>;
      return list.map<Friend>((dynamic model) => Friend.fromJson(model as Map<String, dynamic>)).toList();
    } catch (e) {
      throw ApiException.fromError(e);
    }
  }

  Future<List<Friend>> getFriends() async {
    try {
      final response = await dio.get<String>(
        '/insta/friends',
        options: _requestOptions,
      );
      final list = await jsonDecodeAsync(response.data) as List<dynamic>;
      return list.map<Friend>((dynamic model) => Friend.fromJson(model as Map<String, dynamic>)).toList();
    } catch (e) {
      throw ApiException.fromError(e);
    }
  }

  Future<List<Friend>> getLostFollowers() async {
    try {
      final response = await dio.get<String>(
        '/insta/lost-followers',
        options: _requestOptions,
      );
      final list = await jsonDecodeAsync(response.data) as List<dynamic>;
      return list.map<Friend>((dynamic model) => Friend.fromJson(model as Map<String, dynamic>)).toList();
    } catch (e) {
      throw ApiException.fromError(e);
    }
  }

  Future<List<Friend>> getAudience() async {
    try {
      final response = await dio.get<String>(
        '/insta/audience',
        options: _requestOptions,
      );
      final list = await jsonDecodeAsync(response.data) as List<dynamic>;
      return list.map<Friend>((dynamic model) => Friend.fromJson(model as Map<String, dynamic>)).toList();
    } catch (e) {
      throw ApiException.fromError(e);
    }
  }
}

class ApiException extends AppException {
  ApiException({String code, String message}) : super(code: code, message: message);
  factory ApiException.fromError(dynamic e) {
    if (e is DioError) {
      DioError dioError = e;
      switch (dioError.type) {
        case DioErrorType.CONNECT_TIMEOUT:
          return ApiException(message: 'ApiConnectionTimeOut');
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          return ApiException(message: 'ApiReceiveTimeOut');
          break;
        case DioErrorType.SEND_TIMEOUT:
          return ApiException(message: 'ApiSendTimeOut');
          break;
        case DioErrorType.RESPONSE:
          return ApiException.fromResponse(dioError.response);
          break;
        case DioErrorType.CANCEL:
          return ApiException(message: 'ApiRequestCancel');
          break;
        case DioErrorType.DEFAULT:
          return ApiException(message: AppString.unExpectedErrorOccurred);
          break;
      }
    }
    return ApiException(message: AppString.unExpectedErrorOccurred);
  }
  factory ApiException.fromResponse(Response<dynamic> response) {
    var responseMessage = '';
    try {
      var errorModel = ErrorModel.fromJson(json.decode(response.data as String) as Map<String, dynamic>);
      switch (errorModel.type) {
        case 'login-failed':
          responseMessage = 'AuthenticationFailed';
          //  case 'XXXX':
          // responseMessage = 'YYYY';
          break;
        default:
          responseMessage = AppString.unExpectedErrorOccurred;
      }
    } catch (e) {
      responseMessage = AppString.unExpectedErrorOccurred;
    }
    return ApiException(message: responseMessage);
  }
}
