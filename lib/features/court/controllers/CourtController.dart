import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../auth/models/secure_storage_model.dart';
import '../models/court_filter_model.dart';
import '../models/court_model.dart';
import '../repositorys/CourtRepository.dart';

final CourtControllerProvider =
    StateNotifierProvider<CourtStateNotifier, CourtState>((ref) {
  final courtRepository = ref.watch(courtRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);

  return CourtStateNotifier(
    courtRepository: courtRepository,
    storage: storage,
    ref: ref,
  );
});

class CourtStateNotifier extends StateNotifier<CourtState> {
  final CourtRepository courtRepository;
  final FlutterSecureStorage storage;
  final Ref _ref;

  CourtStateNotifier({
    required this.courtRepository,
    required this.storage,
    required Ref ref,
  })  : _ref = ref,
        super(CourtInitial()) {}

  Future<List<CourtModel>> getCourtList(CourtFilterModel filterModel) async {
    try {
      // courtRepository에서 filterModel을 사용하여 필터링된 플레이어 목록을 조회
      // 페이지 정보도 함께 전달합니다.
      final response = await courtRepository.getCourtListFiltered(
        filterModel,
      );
      // 상태 업데이트 (조회 성공)
      state = CourtSuccess(response);

      // 서버 응답 반환
      return response;
    } catch (e) {
      // 상태 업데이트 (조회 실패)
      state = CourtFailure("조회 중 에러: $e");

      // 예외 발생시, 해당 예외를 다시 던짐
      throw e;
    }
  }

  Future<CourtModel> getCourtDetail(int id) async {
    try {
      // courtRepository에서 courtId를 사용하여 특정 선수의 상세 정보를 조회
      final response = await courtRepository.getCourtDetail(id);

      // 상태 업데이트 (조회 성공)
      state = CourtSuccess(response);

      // 서버 응답 반환
      return response;
    } catch (e) {
      // 상태 업데이트 (조회 실패)
      state = CourtFailure("상세 정보 조회 중 에러: $e");

      // 예외 발생시, 해당 예외를 다시 던짐
      throw e;
    }
  }
}

// 파일 업로드 상태를 나타내는 클래스
abstract class CourtState {}

class CourtInitial extends CourtState {}

class CourtLoding extends CourtState {}

class CourtSuccess extends CourtState {
  final dynamic data;

  CourtSuccess(this.data);
}

class CourtFailure extends CourtState {
  final String message;

  CourtFailure(this.message);
}
