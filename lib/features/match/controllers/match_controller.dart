import 'package:derbymatch/features/match/commands/match_command.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../auth/models/secure_storage_model.dart';
import '../commands/match_filter_command.dart';
import '../models/match_model.dart';
import '../models/match_participant_model.dart';
import '../repositorys/match_repository.dart';

final MatchControllerProvider =
    StateNotifierProvider<MatchStateNotifier, MatchState>((ref) {
  final matchRepository = ref.watch(matchRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);

  return MatchStateNotifier(
    matchRepository: matchRepository,
    storage: storage,
    ref: ref,
  );
});

class MatchStateNotifier extends StateNotifier<MatchState> {
  final MatchRepository matchRepository;
  final FlutterSecureStorage storage;
  final Ref _ref;

  MatchStateNotifier({
    required this.matchRepository,
    required this.storage,
    required Ref ref,
  })  : _ref = ref,
        super(MatchInitial()) {}

  Future<List<MatchModel>> getMyMatchList() async {
    try {
      // matchRepository에서 filterModel을 사용하여 필터링된 플레이어 목록을 조회
      // 페이지 정보도 함께 전달합니다.
      final response = await matchRepository.getMyMatchList();
      // 상태 업데이트 (조회 성공)
      state = MatchSuccess(response);

      // 서버 응답 반환
      return response;
    } catch (e) {
      // 상태 업데이트 (조회 실패)
      state = MatchFailure("조회 중 에러: $e");

      // 예외 발생시, 해당 예외를 다시 던짐
      throw e;
    }
  }

  Future<List<MatchModel>> getMatchList(MatchFilterCommand filterModel) async {
    try {
      // matchRepository에서 filterModel을 사용하여 필터링된 플레이어 목록을 조회
      // 페이지 정보도 함께 전달합니다.
      final response = await matchRepository.getMatchListFiltered(
        filterModel,
      );
      // 상태 업데이트 (조회 성공)
      state = MatchSuccess(response);

      // 서버 응답 반환
      return response;
    } catch (e) {
      // 상태 업데이트 (조회 실패)
      state = MatchFailure("조회 중 에러: $e");

      // 예외 발생시, 해당 예외를 다시 던짐
      throw e;
    }
  }

  Future<MatchModel> getMatchDetail(int id) async {
    try {
      // matchRepository에서 matchId를 사용하여 특정 선수의 상세 정보를 조회
      final response = await matchRepository.getMatchDetail(id);

      // 상태 업데이트 (조회 성공)
      state = MatchSuccess(response);

      // 서버 응답 반환
      return response;
    } catch (e) {
      // 상태 업데이트 (조회 실패)
      state = MatchFailure("상세 정보 조회 중 에러: $e");

      // 예외 발생시, 해당 예외를 다시 던짐
      throw e;
    }
  }

  Future<List<MatchParticipantModel>> getMatchParticipantList(int id) async {
    try {
      final response = await matchRepository.getMatchParticipantList(id);

      // 상태 업데이트 (조회 성공)
      state = MatchSuccess(response);

      return response;
    } catch (e) {
      // 상태 업데이트 (조회 실패)
      state = MatchFailure("팀 멤버 조회 중 에러: $e");

      throw e;
    }
  }



  Future<MatchModel> editMatchModel({
    required MatchModel matchModel,
    required bool isSave,
  }) async {
    if (isSave) {
      final resp = await matchRepository.editMatchModel(
        matchModel: matchModel,
      );
      matchModel = resp;
    }
    // 항상 상태를 업데이트하도록 변경합니다.
    state = MatchSuccess(matchModel); // `MatchSuccess` 상태로 `matchModel`을 포장합니다.

    return matchModel;
  }
}

// 파일 업로드 상태를 나타내는 클래스
abstract class MatchState {}

class MatchInitial extends MatchState {}

class MatchLoading extends MatchState {}

class MatchSuccess extends MatchState {
  final dynamic data;

  MatchSuccess(this.data);
}

class MatchFailure extends MatchState {
  final String message;

  MatchFailure(this.message);
}
