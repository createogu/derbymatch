import 'package:derbymatch/features/team/command/team_photo_commandl.dart';
import 'package:derbymatch/features/team/models/team_photo_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/dio/dio.dart';
import '../command/team_schedule_info_command.dart';
import '../models/team_filter_model.dart';
import '../models/team_member_model.dart';
import '../models/team_model.dart';
import '../models/team_schedule_info_model.dart';

final teamRepositoryProvider = Provider<TeamRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return TeamRepository(dio, baseUrl: Constants.ip + '/team');
});

class TeamRepository {
  final Dio _dio;
  final String? _baseUrl;

  TeamRepository(this._dio, {String? baseUrl}) : _baseUrl = baseUrl;

  Future<List<TeamModel>> getTeamListFiltered(
      TeamFilterModel teamFilter) async {
    try {
      // TeamFilterModel에 페이지 정보 추가
      // 예를 들어, TeamFilterModel.toMap()이 페이지 정보를 포함하도록 해야 합니다.
      final requestData = teamFilter.toMap();

      final response = await _dio.post(
        '$_baseUrl/list',
        options: Options(
          headers: {'accessToken': 'true'},
          responseType: ResponseType.json,
        ),
        data: requestData,
      );
      if (response.statusCode == 200) {
        // JSON 데이터를 TeamModel의 리스트로 변환
        return (response.data['data'] as List)
            .map((item) => TeamModel.fromMap(item))
            .toList();
      } else {
        throw Exception('Failed to retrieve team list');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TeamModel>> getMyTeamList() async {
    try {
      // TeamFilterModel에 페이지 정보 추가
      // 예를 들어, TeamFilterModel.toMap()이 페이지 정보를 포함하도록 해야 합니다.

      final response = await _dio.post(
        '$_baseUrl/myList',
        options: Options(
          headers: {'accessToken': 'true'},
          responseType: ResponseType.json,
        ),
      );
      if (response.statusCode == 200) {
        // JSON 데이터를 TeamModel의 리스트로 변환
        return (response.data as List)
            .map((item) => TeamModel.fromMap(item))
            .toList();
      } else {
        throw Exception('Failed to retrieve team list');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<TeamModel> getTeamDetail(int team_id) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/detail/$team_id',
        options: Options(
          headers: {'accessToken': 'true'},
          responseType: ResponseType.json,
        ),
      );

      if (response.statusCode == 200) {
        // JSON 데이터를 TeamModel로 변환
        return TeamModel.fromMap(response.data);
      } else {
        throw Exception('Failed to retrieve team detail');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TeamMemberModel>> getTeamMemberList(int team_id) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/teamMemberList/$team_id',
        options: Options(
          headers: {'accessToken': 'true'},
          responseType: ResponseType.json,
        ),
      );
      if (response.statusCode == 200) {
        // JSON 데이터를 TeamModel의 리스트로 변환
        return (response.data as List)
            .map((item) => TeamMemberModel.fromMap(item))
            .toList();
      } else {
        throw Exception('Failed to retrieve team detail');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<TeamModel> editTeamModel({required TeamModel teamModel}) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/editTeam',
        data: teamModel.toMap(),
        // teamModel을 JSON 형식으로 변환 (필요하다면 .toJson() 메소드 구현)
        options: Options(
          headers: {
            'accessToken': 'true',
            'Content-Type': 'application/json', // 여기에 Content-Type 추가
          },
        ),
      );

      if (response.statusCode == 200) {
        return TeamModel.fromMap(response.data);
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> addTeamPhotos(TeamPhotoCommand teamPhotoCommand) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/addTeamPhotos', // 서버의 엔드포인트에 맞춰 수정 필요
        data: teamPhotoCommand.toMap(),
        options: Options(
          headers: {
            'accessToken': 'true',
            'Content-Type': 'application/json',
          },
        ),
      );

      return response.statusCode == 200;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TeamPhotoModel>> getTeamPhotosList(int teamId) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/teamPhotosList/$teamId',
        options: Options(
          headers: {'accessToken': 'true'},
          responseType: ResponseType.json,
        ),
      );
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((item) => TeamPhotoModel.fromMap(item))
            .toList();
      } else {
        throw Exception('Failed to retrieve team schedules');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<TeamPhotoModel> getTeamPhotoDetail(int teamId, int seq) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/teamPhotoDetail/$teamId/$seq',
        options: Options(
          headers: {'accessToken': 'true'},
          responseType: ResponseType.json,
        ),
      );
      if (response.statusCode == 200) {
        return TeamPhotoModel.fromMap(response.data);
      } else {
        throw Exception('Failed to retrieve team schedule detail');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> addTeamSchedule(
      TeamScheduleInfoCommand scheduleInfoCommand) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/addTeamSchedule', // 서버의 엔드포인트에 맞춰 수정 필요
        data: scheduleInfoCommand.toMap(),
        options: Options(
          headers: {
            'accessToken': 'true',
            'Content-Type': 'application/json',
          },
        ),
      );

      return response.statusCode == 200;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TeamScheduleInfoModel>> getTeamSchedules(int teamId) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/teamScheduleList/$teamId',
        options: Options(
          headers: {'accessToken': 'true'},
          responseType: ResponseType.json,
        ),
      );
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((item) => TeamScheduleInfoModel.fromMap(item))
            .toList();
      } else {
        throw Exception('Failed to retrieve team schedules');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<TeamScheduleInfoModel> getTeamScheduleDetail(
      int teamId, int seq) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/teamScheduleDetail/$teamId/$seq',
        options: Options(
          headers: {'accessToken': 'true'},
          responseType: ResponseType.json,
        ),
      );
      if (response.statusCode == 200) {
        return TeamScheduleInfoModel.fromMap(response.data);
      } else {
        throw Exception('Failed to retrieve team schedule detail');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<TeamModel> createTeamModel({required TeamModel teamModel}) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/createTeam',
        data: teamModel.toMap(),
        // teamModel을 JSON 형식으로 변환 (필요하다면 .toJson() 메소드 구현)
        options: Options(
          headers: {
            'accessToken': 'true',
            'Content-Type': 'application/json', // 여기에 Content-Type 추가
          },
        ),
      );

      if (response.statusCode == 200) {
        return TeamModel.fromMap(response.data);
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      rethrow;
    }
  }
}
