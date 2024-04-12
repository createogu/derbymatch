import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/constants.dart';
import '../../../core/dio/dio.dart';
import '../models/user_model.dart';

final userMeRepositoryProvider = Provider<UserMeRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return UserMeRepository(dio, baseUrl: Constants.ip + '/user');
});

class UserMeRepository {
  final Dio _dio;
  final String? _baseUrl;

  UserMeRepository(this._dio, {String? baseUrl}) : _baseUrl = baseUrl;

  Future<UserModel> getMe() async {
    try {
      final response = await _dio.get(
        '$_baseUrl/me',
        options: Options(headers: {'accessToken': 'true'}),
      );

      if (response.statusCode == 200) {
        return UserModel.fromMap(response.data);
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> editUserModel({required UserModel userModel}) async {
    try {
      final response = await _dio.put(
        '$_baseUrl/editProfile',
        data: userModel.toMap(),
        // userModel을 JSON 형식으로 변환 (필요하다면 .toJson() 메소드 구현)
        options: Options(
          headers: {
            'accessToken': 'true',
            'Content-Type': 'application/json', // 여기에 Content-Type 추가
          },
        ),
      );

      if (response.statusCode == 200) {
        return UserModel.fromMap(response.data);
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      rethrow;
    }
  }
}
