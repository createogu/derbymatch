import 'package:derbymatch/core/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/dio/dio.dart';
import '../models/login_response_model.dart';
import '../models/token_response_model.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthRepository(baseUrl: Constants.ip, dio: dio);
});

class AuthRepository {
  final String baseUrl;
  final Dio dio;

  AuthRepository({
    required this.baseUrl,
    required this.dio,
  });

  Future<LoginResponseModel> login({
    required String kakao_access_token,
  }) async {
    final resp = await dio.post('$baseUrl/login/oauth/kakao',
        options: Options(
          headers: {},
        ),
        data: {
          'accessToken': kakao_access_token,
        });
    return LoginResponseModel.fromMap(resp.data);
  }

  Future<TokenResponseModel> token() async {
    final resp = await dio.post(
      '$baseUrl/token',
      options: Options(
        headers: {'refreshToken': 'true'},
      ),
    );
    return TokenResponseModel.fromMap(resp.data);
  }
}
