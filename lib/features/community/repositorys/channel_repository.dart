import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/dio/dio.dart';
import '../models/channel_model.dart';

final channelRepositoryProvider = Provider<ChannelRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return ChannelRepository(dio, baseUrl: Constants.ip + '/channel');
});

class ChannelRepository {
  final Dio _dio;
  final String? _baseUrl;

  ChannelRepository(this._dio, {String? baseUrl}) : _baseUrl = baseUrl;

  Future<List<ChannelModel>> getMyChannelList() async {
    try {
      // ChannelFilterCommand에 페이지 정보 추가
      // 예를 들어, ChannelFilterCommand.toMap()이 페이지 정보를 포함하도록 해야 합니다.

      final response = await _dio.post(
        '$_baseUrl/myChannelList',
        options: Options(
          headers: {'accessToken': 'true'},
          responseType: ResponseType.json,
        ),
      );
      if (response.statusCode == 200) {
        // JSON 데이터를 ChannelModel의 리스트로 변환
        return (response.data as List)
            .map((item) => ChannelModel.fromMap(item))
            .toList();
      } else {
        throw Exception('Failed to retrieve channel list');
      }
    } catch (e) {
      rethrow;
    }
  }
}
