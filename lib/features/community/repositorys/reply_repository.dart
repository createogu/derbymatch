import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/dio/dio.dart';
import '../commands/reply_command.dart';
import '../commands/reply_filter_command.dart';
import '../models/reply_model.dart';

final replyRepositoryProvider = Provider<ReplyRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return ReplyRepository(dio, baseUrl: Constants.ip + '/reply');
});

class ReplyRepository {
  final Dio _dio;
  final String? _baseUrl;

  ReplyRepository(this._dio, {String? baseUrl}) : _baseUrl = baseUrl;

  Future<List<ReplyModel>> getReplyListFiltered(
      ReplyFilterCommand replyFilter) async {
    try {
      // ReplyFilterCommand에 페이지 정보 추가
      // 예를 들어, ReplyFilterCommand.toMap()이 페이지 정보를 포함하도록 해야 합니다.
      final requestData = replyFilter.toMap();

      final response = await _dio.post(
        '$_baseUrl/list',
        options: Options(
          headers: {'accessToken': 'true'},
          responseType: ResponseType.json,
        ),
        data: requestData,
      );
      if (response.statusCode == 200) {
        // JSON 데이터를 ReplyModel의 리스트로 변환
        return (response.data['data'] as List)
            .map((item) => ReplyModel.fromMap(item))
            .toList();
      } else {
        throw Exception('Failed to retrieve reply list');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ReplyModel>> getMyReplyList() async {
    try {
      // ReplyFilterCommand에 페이지 정보 추가
      // 예를 들어, ReplyFilterCommand.toMap()이 페이지 정보를 포함하도록 해야 합니다.

      final response = await _dio.post(
        '$_baseUrl/myList',
        options: Options(
          headers: {'accessToken': 'true'},
          responseType: ResponseType.json,
        ),
      );
      if (response.statusCode == 200) {
        // JSON 데이터를 ReplyModel의 리스트로 변환
        return (response.data as List)
            .map((item) => ReplyModel.fromMap(item))
            .toList();
      } else {
        throw Exception('Failed to retrieve reply list');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ReplyModel> getReplyDetail(int reply_id) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/detail/$reply_id',
        options: Options(
          headers: {'accessToken': 'true'},
          responseType: ResponseType.json,
        ),
      );

      if (response.statusCode == 200) {
        // JSON 데이터를 ReplyModel로 변환
        return ReplyModel.fromMap(response.data);
      } else {
        throw Exception('Failed to retrieve reply detail');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ReplyModel> editReplyModel({required ReplyModel replyModel}) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/editReply',
        data: replyModel.toMap(),
        // replyModel을 JSON 형식으로 변환 (필요하다면 .toJson() 메소드 구현)
        options: Options(
          headers: {
            'accessToken': 'true',
            'Content-Type': 'application/json', // 여기에 Content-Type 추가
          },
        ),
      );

      if (response.statusCode == 200) {
        return ReplyModel.fromMap(response.data);
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ReplyModel> createReply({required ReplyCommand replyCommand}) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/createReply',
        data: replyCommand.toMap(),
        // replyModel을 JSON 형식으로 변환 (필요하다면 .toJson() 메소드 구현)
        options: Options(
          headers: {
            'accessToken': 'true',
            'Content-Type': 'application/json', // 여기에 Content-Type 추가
          },
        ),
      );
      print(response);
      if (response.statusCode == 200) {
        return ReplyModel.fromMap(response.data);
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> replyToggleLike({required int reply_id}) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/toggleLike/$reply_id',
        options: Options(
          headers: {
            'accessToken': 'true', // 액세스 토큰을 사용, 필요에 따라 수정 가능
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        // 서버에서 좋아요 토글 결과를 확인하고 필요한 UI 업데이트를 수행
        print('Toggle like success: ${response.data}');
      } else {
        throw Exception('Failed to toggle like');
      }
    } catch (e) {
      print('Error toggling like: $e');
      rethrow;
    }
  }
}
