import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/constants.dart';
import '../../dio/dio.dart';
import '../models/CommCodeModel.dart';

final commCodeRepositoryProvider = Provider<CommCodeRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return CommCodeRepository(dio, baseUrl: Constants.ip + '/common');
});

class CommCodeRepository {
  final Dio _dio;
  final String? _baseUrl;

  CommCodeRepository(this._dio, {String? baseUrl}) : _baseUrl = baseUrl;

  Future<CommonCode> fetchCommCodes() async {
    try {
      final response = await _dio.get(
        '$_baseUrl/getAllCommCodes',
        options: Options(headers: {'accessToken': 'true'}),
      );
      if (response.statusCode == 200) {
        return CommonCode.fromMap(response.data);
      } else {
        throw Exception('Failed to fetch common codes');
      }
    } catch (e) {
      rethrow;
    }
  }
}
