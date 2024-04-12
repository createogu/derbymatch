import 'package:derbymatch/features/team/command/team_photo_commandl.dart';
import 'package:derbymatch/features/team/models/team_photo_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../auth/models/secure_storage_model.dart';
import '../command/team_schedule_info_command.dart';
import '../models/team_filter_model.dart';
import '../models/team_member_model.dart';
import '../models/team_model.dart';
import '../models/team_schedule_info_model.dart';
import '../repositorys/TeamRepository.dart';

final TeamControllerProvider =
    StateNotifierProvider<TeamStateNotifier, TeamState>((ref) {
  final teamRepository = ref.watch(teamRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);

  return TeamStateNotifier(
    teamRepository: teamRepository,
    storage: storage,
    ref: ref,
  );
});

class TeamStateNotifier extends StateNotifier<TeamState> {
  final TeamRepository teamRepository;
  final FlutterSecureStorage storage;
  final Ref _ref;

  TeamStateNotifier({
    required this.teamRepository,
    required this.storage,
    required Ref ref,
  })  : _ref = ref,
        super(TeamInitial()) {}

  Future<List<TeamModel>> getMyTeamList() async {
    try {
      // teamRepository에서 filterModel을 사용하여 필터링된 플레이어 목록을 조회
      // 페이지 정보도 함께 전달합니다.
      final response = await teamRepository.getMyTeamList();
      // 상태 업데이트 (조회 성공)
      state = TeamSuccess(response);

      // 서버 응답 반환
      return response;
    } catch (e) {
      // 상태 업데이트 (조회 실패)
      state = TeamFailure("조회 중 에러: $e");

      // 예외 발생시, 해당 예외를 다시 던짐
      throw e;
    }
  }

  Future<List<TeamModel>> getTeamList(TeamFilterModel filterModel) async {
    try {
      // teamRepository에서 filterModel을 사용하여 필터링된 플레이어 목록을 조회
      // 페이지 정보도 함께 전달합니다.
      final response = await teamRepository.getTeamListFiltered(
        filterModel,
      );
      // 상태 업데이트 (조회 성공)
      state = TeamSuccess(response);

      // 서버 응답 반환
      return response;
    } catch (e) {
      // 상태 업데이트 (조회 실패)
      state = TeamFailure("조회 중 에러: $e");

      // 예외 발생시, 해당 예외를 다시 던짐
      throw e;
    }
  }

  Future<TeamModel> getTeamDetail(int id) async {
    try {
      // teamRepository에서 teamId를 사용하여 특정 선수의 상세 정보를 조회
      final response = await teamRepository.getTeamDetail(id);

      // 상태 업데이트 (조회 성공)
      state = TeamSuccess(response);

      // 서버 응답 반환
      return response;
    } catch (e) {
      // 상태 업데이트 (조회 실패)
      state = TeamFailure("상세 정보 조회 중 에러: $e");

      // 예외 발생시, 해당 예외를 다시 던짐
      throw e;
    }
  }

  Future<List<TeamMemberModel>> getTeamMemberList(int id) async {
    try {
      final response = await teamRepository.getTeamMemberList(id);

      // 상태 업데이트 (조회 성공)
      state = TeamSuccess(response);

      return response;
    } catch (e) {
      // 상태 업데이트 (조회 실패)
      state = TeamFailure("팀 멤버 조회 중 에러: $e");

      throw e;
    }
  }

  Future<TeamModel> editTeamModel({
    required TeamModel teamModel,
    required bool isSave,
  }) async {
    if (isSave) {
      final resp = await teamRepository.editTeamModel(
        teamModel: teamModel,
      );
      teamModel = resp;
    }
    // 항상 상태를 업데이트하도록 변경합니다.
    state = TeamSuccess(teamModel); // `TeamSuccess` 상태로 `teamModel`을 포장합니다.

    return teamModel;
  }

  Future<void> addTeamSchedule(
      TeamScheduleInfoCommand scheduleInfoCommand) async {
    state = TeamLoading(); // 로딩 상태로 전환
    try {
      bool result = await teamRepository.addTeamSchedule(scheduleInfoCommand);
      if (result) {
        state = TeamSuccess('일정이 성공적으로 추가되었습니다.');
      } else {
        state = TeamFailure('일정 추가 실패');
      }
    } catch (e) {
      state = TeamFailure(e.toString());
    }
  }

  Future<List<TeamScheduleInfoModel>> getTeamSchedules(int teamId) async {
    try {
      final response = await teamRepository.getTeamSchedules(teamId);
      state = TeamSuccess(response);
      return response;
    } catch (e) {
      state = TeamFailure("팀 스케줄 목록 조회 중 에러: $e");
      throw e;
    }
  }

  Future<TeamScheduleInfoModel> getTeamScheduleDetail(
      int teamId, int seq) async {
    state = TeamLoading();
    try {
      final response = await teamRepository.getTeamScheduleDetail(teamId, seq);
      state = TeamSuccess(response);
      return response;
    } catch (e) {
      state = TeamFailure("팀 스케줄 상세 조회 중 에러: $e");
      throw e;
    }
  }

  Future<void> addTeamPhotos(TeamPhotoCommand teamPhotoCommand) async {
    state = TeamLoading(); // 로딩 상태로 전환
    try {
      bool result = await teamRepository.addTeamPhotos(teamPhotoCommand);
      if (result) {
        state = TeamSuccess('사진이 성공적으로 추가되었습니다.');
      } else {
        state = TeamFailure('사진 추가 실패');
      }
    } catch (e) {
      state = TeamFailure(e.toString());
    }
  }

  Future<List<TeamPhotoModel>> getTeamPhotosList(int teamId) async {
    try {
      final response = await teamRepository.getTeamPhotosList(teamId);
      state = TeamSuccess(response);
      return response;
    } catch (e) {
      state = TeamFailure("팀 스케줄 목록 조회 중 에러: $e");
      throw e;
    }
  }

  Future<TeamPhotoModel> getTeamPhotoDetail(int teamId, int seq) async {
    state = TeamLoading();
    try {
      final response = await teamRepository.getTeamPhotoDetail(teamId, seq);
      state = TeamSuccess(response);
      return response;
    } catch (e) {
      state = TeamFailure("팀 스케줄 상세 조회 중 에러: $e");
      throw e;
    }
  }
}

// 파일 업로드 상태를 나타내는 클래스
abstract class TeamState {}

class TeamInitial extends TeamState {}

class TeamLoading extends TeamState {}

class TeamSuccess extends TeamState {
  final dynamic data;

  TeamSuccess(this.data);
}

class TeamFailure extends TeamState {
  final String message;

  TeamFailure(this.message);
}
