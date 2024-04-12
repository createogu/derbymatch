import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/dio/dio.dart';
import '../models/court_filter_model.dart';
import '../models/court_model.dart';

final courtRepositoryProvider = Provider<CourtRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return CourtRepository(dio, baseUrl: Constants.ip + '/court');
});

class CourtRepository {
  final Dio _dio;
  final String? _baseUrl;

  CourtRepository(this._dio, {String? baseUrl}) : _baseUrl = baseUrl;

  Future<List<CourtModel>> getCourtListFiltered(
      CourtFilterModel courtFilter) async {
    try {
      // CourtFilterModel에 페이지 정보 추가
      // 예를 들어, CourtFilterModel.toMap()이 페이지 정보를 포함하도록 해야 합니다.
      final requestData = courtFilter.toMap();

      final response = await _dio.post(
        '$_baseUrl/list',
        options: Options(
          headers: {'accessToken': 'true'},
          responseType: ResponseType.json,
        ),
        data: requestData,
      );
      if (response.statusCode == 200) {
        // JSON 데이터를 CourtModel의 리스트로 변환
        return (response.data['data'] as List)
            .map((item) => CourtModel.fromMap(item))
            .toList();
      } else {
        throw Exception('Failed to retrieve court list');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<CourtModel> getCourtDetail(int id) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/detail/$id',
        options: Options(
          headers: {'accessToken': 'true'},
          responseType: ResponseType.json,
        ),
      );

      if (response.statusCode == 200) {
        // JSON 데이터를 CourtModel로 변환
        return CourtModel.fromMap(response.data);
      } else {
        throw Exception('Failed to retrieve court detail');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<CourtModel> editCourtModel({required CourtModel courtModel}) async {
    try {
      final response = await _dio.put(
        '$_baseUrl/editCourt',
        data: courtModel.toMap(),
        // courtModel을 JSON 형식으로 변환 (필요하다면 .toJson() 메소드 구현)
        options: Options(
          headers: {
            'accessToken': 'true',
            'Content-Type': 'application/json', // 여기에 Content-Type 추가
          },
        ),
      );

      if (response.statusCode == 200) {
        return CourtModel.fromMap(response.data);
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      rethrow;
    }
  }
}
