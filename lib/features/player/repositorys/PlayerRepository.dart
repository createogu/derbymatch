import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/dio/dio.dart';
import '../models/player_filter_model.dart';
import '../models/player_model.dart';

final playerRepositoryProvider = Provider<PlayerRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return PlayerRepository(dio, baseUrl: Constants.ip + '/player');
});

class PlayerRepository {
  final Dio _dio;
  final String? _baseUrl;

  PlayerRepository(this._dio, {String? baseUrl}) : _baseUrl = baseUrl;

  Future<List<PlayerModel>> getPlayerListFiltered(
      PlayerFilterModel playerFilter) async {
    try {
      // PlayerFilterModel에 페이지 정보 추가
      // 예를 들어, PlayerFilterModel.toMap()이 페이지 정보를 포함하도록 해야 합니다.
      final requestData = playerFilter.toMap();

      final response = await _dio.post(
        '$_baseUrl/list',
        options: Options(
          headers: {'accessToken': 'true'},
          responseType: ResponseType.json,
        ),
        data: requestData,
      );
      if (response.statusCode == 200) {
        // JSON 데이터를 PlayerModel의 리스트로 변환
        return (response.data['data'] as List)
            .map((item) => PlayerModel.fromMap(item))
            .toList();
      } else {
        throw Exception('Failed to retrieve player list');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<PlayerModel> getPlayerDetail(int user_id) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/detail/$user_id',
        options: Options(
          headers: {'accessToken': 'true'},
          responseType: ResponseType.json,
        ),
      );

      if (response.statusCode == 200) {
        // JSON 데이터를 PlayerModel로 변환
        return PlayerModel.fromMap(response.data);
      } else {
        throw Exception('Failed to retrieve player detail');
      }
    } catch (e) {
      rethrow;
    }
  }
}
