import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../auth/models/secure_storage_model.dart';
import '../models/player_filter_model.dart';
import '../models/player_model.dart';
import '../repositorys/PlayerRepository.dart';

final PlayerControllerProvider =
    StateNotifierProvider<PlayerStateNotifier, PlayerState>((ref) {
  final playerRepository = ref.watch(playerRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);

  return PlayerStateNotifier(
    playerRepository: playerRepository,
    storage: storage,
    ref: ref,
  );
});

class PlayerStateNotifier extends StateNotifier<PlayerState> {
  final PlayerRepository playerRepository;
  final FlutterSecureStorage storage;
  final Ref _ref;

  PlayerStateNotifier({
    required this.playerRepository,
    required this.storage,
    required Ref ref,
  })  : _ref = ref,
        super(PlayerInitial()) {
    null;
  }

  Future<List<PlayerModel>> getPlayerList(PlayerFilterModel filterModel) async {
    try {
      // playerRepository에서 filterModel을 사용하여 필터링된 플레이어 목록을 조회
      // 페이지 정보도 함께 전달합니다.
      final response = await playerRepository.getPlayerListFiltered(
        filterModel,
      );
      // 상태 업데이트 (조회 성공)
      state = PlayerSuccess(response);

      // 서버 응답 반환
      return response;
    } catch (e) {
      // 상태 업데이트 (조회 실패)
      state = PlayerFailure("조회 중 에러: $e");

      // 예외 발생시, 해당 예외를 다시 던짐
      throw e;
    }
  }

  Future<PlayerModel> getPlayerDetail(int user_id) async {
    try {
      // playerRepository에서 playerId를 사용하여 특정 선수의 상세 정보를 조회
      final response = await playerRepository.getPlayerDetail(user_id);

      // 상태 업데이트 (조회 성공)
      state = PlayerSuccess(response);

      // 서버 응답 반환
      return response;
    } catch (e) {
      // 상태 업데이트 (조회 실패)
      state = PlayerFailure("상세 정보 조회 중 에러: $e");

      // 예외 발생시, 해당 예외를 다시 던짐
      throw e;
    }
  }
}

// 파일 업로드 상태를 나타내는 클래스
abstract class PlayerState {}

class PlayerInitial extends PlayerState {}

class PlayerLoding extends PlayerState {}

class PlayerSuccess extends PlayerState {
  final dynamic data;

  PlayerSuccess(this.data);
}

class PlayerFailure extends PlayerState {
  final String message;

  PlayerFailure(this.message);
}
