import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/dio/dio.dart';
import '../commands/comment_command.dart';
import '../commands/comment_filter_command.dart';
import '../models/comment_model.dart';

final commentRepositoryProvider = Provider<CommentRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return CommentRepository(dio, baseUrl: Constants.ip + '/comment');
});

class CommentRepository {
  final Dio _dio;
  final String? _baseUrl;

  CommentRepository(this._dio, {String? baseUrl}) : _baseUrl = baseUrl;

  Future<List<CommentModel>> getCommentListFiltered(
      CommentFilterCommand commentFilter) async {
    try {
      // CommentFilterCommand에 페이지 정보 추가
      // 예를 들어, CommentFilterCommand.toMap()이 페이지 정보를 포함하도록 해야 합니다.
      final requestData = commentFilter.toMap();

      final response = await _dio.post(
        '$_baseUrl/list',
        options: Options(
          headers: {'accessToken': 'true'},
          responseType: ResponseType.json,
        ),
        data: requestData,
      );
      if (response.statusCode == 200) {
        // JSON 데이터를 CommentModel의 리스트로 변환
        return (response.data['data'] as List)
            .map((item) => CommentModel.fromMap(item))
            .toList();
      } else {
        throw Exception('Failed to retrieve comment list');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CommentModel>> getMyCommentList() async {
    try {
      // CommentFilterCommand에 페이지 정보 추가
      // 예를 들어, CommentFilterCommand.toMap()이 페이지 정보를 포함하도록 해야 합니다.

      final response = await _dio.post(
        '$_baseUrl/myList',
        options: Options(
          headers: {'accessToken': 'true'},
          responseType: ResponseType.json,
        ),
      );
      if (response.statusCode == 200) {
        // JSON 데이터를 CommentModel의 리스트로 변환
        return (response.data as List)
            .map((item) => CommentModel.fromMap(item))
            .toList();
      } else {
        throw Exception('Failed to retrieve comment list');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<CommentModel> getCommentDetail(int comment_id) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/detail/$comment_id',
        options: Options(
          headers: {'accessToken': 'true'},
          responseType: ResponseType.json,
        ),
      );

      if (response.statusCode == 200) {
        // JSON 데이터를 CommentModel로 변환
        return CommentModel.fromMap(response.data);
      } else {
        throw Exception('Failed to retrieve comment detail');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<CommentModel> editCommentModel({required CommentModel commentModel}) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/editComment',
        data: commentModel.toMap(),
        // commentModel을 JSON 형식으로 변환 (필요하다면 .toJson() 메소드 구현)
        options: Options(
          headers: {
            'accessToken': 'true',
            'Content-Type': 'application/json', // 여기에 Content-Type 추가
          },
        ),
      );

      if (response.statusCode == 200) {
        return CommentModel.fromMap(response.data);
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<CommentModel> createComment({required CommentCommand commentCommand}) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/createComment',
        data: commentCommand.toMap(),
        // commentModel을 JSON 형식으로 변환 (필요하다면 .toJson() 메소드 구현)
        options: Options(
          headers: {
            'accessToken': 'true',
            'Content-Type': 'application/json', // 여기에 Content-Type 추가
          },
        ),
      );
      print(response);
      if (response.statusCode == 200) {
        return CommentModel.fromMap(response.data);
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> commentToggleLike({required int comment_id}) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/toggleLike/$comment_id',
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
