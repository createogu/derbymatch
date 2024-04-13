import 'package:derbymatch/features/match/commands/match_command.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/dio/dio.dart';
import '../commands/match_filter_command.dart';
import '../models/match_model.dart';
import '../models/match_participant_model.dart';

final matchRepositoryProvider = Provider<MatchRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return MatchRepository(dio, baseUrl: Constants.ip + '/match');
});

class MatchRepository {
  final Dio _dio;
  final String? _baseUrl;

  MatchRepository(this._dio, {String? baseUrl}) : _baseUrl = baseUrl;

  Future<List<MatchModel>> getMatchListFiltered(
      MatchFilterCommand matchFilter) async {
    try {
      // MatchFilterCommand에 페이지 정보 추가
      // 예를 들어, MatchFilterCommand.toMap()이 페이지 정보를 포함하도록 해야 합니다.
      final requestData = matchFilter.toMap();

      final response = await _dio.post(
        '$_baseUrl/list',
        options: Options(
          headers: {'accessToken': 'true'},
          responseType: ResponseType.json,
        ),
        data: requestData,
      );
      if (response.statusCode == 200) {
        // JSON 데이터를 MatchModel의 리스트로 변환
        return (response.data['data'] as List)
            .map((item) => MatchModel.fromMap(item))
            .toList();
      } else {
        throw Exception('Failed to retrieve match list');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<MatchModel>> getMyMatchList() async {
    try {
      // MatchFilterCommand에 페이지 정보 추가
      // 예를 들어, MatchFilterCommand.toMap()이 페이지 정보를 포함하도록 해야 합니다.

      final response = await _dio.post(
        '$_baseUrl/myList',
        options: Options(
          headers: {'accessToken': 'true'},
          responseType: ResponseType.json,
        ),
      );
      if (response.statusCode == 200) {
        // JSON 데이터를 MatchModel의 리스트로 변환
        return (response.data as List)
            .map((item) => MatchModel.fromMap(item))
            .toList();
      } else {
        throw Exception('Failed to retrieve match list');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<MatchModel> getMatchDetail(int match_id) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/detail/$match_id',
        options: Options(
          headers: {'accessToken': 'true'},
          responseType: ResponseType.json,
        ),
      );

      if (response.statusCode == 200) {
        // JSON 데이터를 MatchModel로 변환
        return MatchModel.fromMap(response.data);
      } else {
        throw Exception('Failed to retrieve match detail');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<MatchParticipantModel>> getMatchParticipantList(
      int match_id) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/matchParticipantList/$match_id',
        options: Options(
          headers: {'accessToken': 'true'},
          responseType: ResponseType.json,
        ),
      );
      if (response.statusCode == 200) {
        // JSON 데이터를 MatchModel의 리스트로 변환
        return (response.data as List)
            .map((item) => MatchParticipantModel.fromMap(item))
            .toList();
      } else {
        throw Exception('Failed to retrieve match detail');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<MatchModel> editMatchModel({required MatchModel matchModel}) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/editMatch',
        data: matchModel.toMap(),
        // matchModel을 JSON 형식으로 변환 (필요하다면 .toJson() 메소드 구현)
        options: Options(
          headers: {
            'accessToken': 'true',
            'Content-Type': 'application/json', // 여기에 Content-Type 추가
          },
        ),
      );

      if (response.statusCode == 200) {
        return MatchModel.fromMap(response.data);
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<MatchModel> createMatchModel(
      {required MatchCommand matchCommand}) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/createMatch',
        data: matchCommand.toMap(),
        // matchModel을 JSON 형식으로 변환 (필요하다면 .toJson() 메소드 구현)
        options: Options(
          headers: {
            'accessToken': 'true',
            'Content-Type': 'application/json', // 여기에 Content-Type 추가
          },
        ),
      );

      if (response.statusCode == 200) {
        return MatchModel.fromMap(response.data);
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      rethrow;
    }
  }
}
