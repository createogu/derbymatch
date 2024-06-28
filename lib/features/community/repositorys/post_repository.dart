import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/dio/dio.dart';
import '../commands/post_command.dart';
import '../commands/post_filter_command.dart';
import '../models/post_model.dart';

final postRepositoryProvider = Provider<PostRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return PostRepository(dio, baseUrl: Constants.ip + '/post');
});

class PostRepository {
  final Dio _dio;
  final String? _baseUrl;

  PostRepository(this._dio, {String? baseUrl}) : _baseUrl = baseUrl;

  Future<List<PostModel>> getPostListFiltered(
      PostFilterCommand postFilter) async {
    try {
      print(1111);
      print(postFilter);
      print(2222);
      // PostFilterCommand에 페이지 정보 추가
      // 예를 들어, PostFilterCommand.toMap()이 페이지 정보를 포함하도록 해야 합니다.
      final requestData = postFilter.toMap();

      final response = await _dio.post(
        '$_baseUrl/list',
        options: Options(
          headers: {'accessToken': 'true'},
          responseType: ResponseType.json,
        ),
        data: requestData,
      );
      if (response.statusCode == 200) {
        // JSON 데이터를 PostModel의 리스트로 변환
        return (response.data['data'] as List)
            .map((item) => PostModel.fromMap(item))
            .toList();
      } else {
        throw Exception('Failed to retrieve post list');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<PostModel>> getMyPostList() async {
    try {
      // PostFilterCommand에 페이지 정보 추가
      // 예를 들어, PostFilterCommand.toMap()이 페이지 정보를 포함하도록 해야 합니다.

      final response = await _dio.post(
        '$_baseUrl/myList',
        options: Options(
          headers: {'accessToken': 'true'},
          responseType: ResponseType.json,
        ),
      );
      if (response.statusCode == 200) {
        // JSON 데이터를 PostModel의 리스트로 변환
        return (response.data as List)
            .map((item) => PostModel.fromMap(item))
            .toList();
      } else {
        throw Exception('Failed to retrieve post list');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<PostModel> getPostDetail(int post_id) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/detail/$post_id',
        options: Options(
          headers: {'accessToken': 'true'},
          responseType: ResponseType.json,
        ),
      );

      if (response.statusCode == 200) {
        // JSON 데이터를 PostModel로 변환
        return PostModel.fromMap(response.data);
      } else {
        throw Exception('Failed to retrieve post detail');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<PostModel> editPostModel({required PostModel postModel}) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/editPost',
        data: postModel.toMap(),
        // postModel을 JSON 형식으로 변환 (필요하다면 .toJson() 메소드 구현)
        options: Options(
          headers: {
            'accessToken': 'true',
            'Content-Type': 'application/json', // 여기에 Content-Type 추가
          },
        ),
      );

      if (response.statusCode == 200) {
        return PostModel.fromMap(response.data);
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<PostModel> createPost({required PostCommand postCommand}) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/createPost',
        data: postCommand.toMap(),
        // postModel을 JSON 형식으로 변환 (필요하다면 .toJson() 메소드 구현)
        options: Options(
          headers: {
            'accessToken': 'true',
            'Content-Type': 'application/json', // 여기에 Content-Type 추가
          },
        ),
      );

      if (response.statusCode == 200) {
        return PostModel.fromMap(response.data);
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> postToggleLike({required int post_id}) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/toggleLike/$post_id',
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
