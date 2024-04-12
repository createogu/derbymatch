import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../features/auth/models/secure_storage_model.dart';
import '../models/CommCodeModel.dart';
import '../repositorys/CommCodeRepository.dart';

final commCodeControllerProvider =
    StateNotifierProvider<CommCodeStateNotifier, CommCodeState>((ref) {
  final commCodeRepository = ref.watch(commCodeRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);

  return CommCodeStateNotifier(
    commCodeRepository: commCodeRepository,
    storage: storage,
  );
});

class CommCodeStateNotifier extends StateNotifier<CommCodeState> {
  final CommCodeRepository commCodeRepository;
  final FlutterSecureStorage storage;

  CommCodeStateNotifier({
    required this.commCodeRepository,
    required this.storage,
  }) : super(CommCodeInitial());

  Future<void> fetchCommCodes() async {
    try {
      final CommonCode commonCodes = await commCodeRepository.fetchCommCodes();
      state = CommCodeSuccess(commonCodes);
    } catch (e) {
      state = CommCodeFailure("공통코드 목록 가져오기 실패: $e");
    }
  }

  // 특정 comm_cd_type에 해당하는 모든 CommCodeModel 반환
  List<CommCodeModel> getCommCodesByType(String commTypeCd) {
    if (state is CommCodeSuccess) {
      return (state as CommCodeSuccess)
              .commonCodes
              .codeCategories[commTypeCd] ??
          [];
    }
    return [];
  }

  String? getCommCodeName(String commTypeCd, String commCd) {
    if (state is CommCodeSuccess) {
      final codes =
          (state as CommCodeSuccess).commonCodes.codeCategories[commTypeCd];
      final code = codes?.firstWhere((code) => code.comm_cd == commCd);
      return code?.comm_cd_nm;
    }
    return null;
  }

  String? getCommCodeImagePath(String commTypeCd, String commCd) {
    if (state is CommCodeSuccess) {
      final codes =
          (state as CommCodeSuccess).commonCodes.codeCategories[commTypeCd];
      final code = codes?.firstWhere((code) => code.comm_cd == commCd);
      return code?.image_path;
    }
    return null;
  }
}

// 상태 클래스들
abstract class CommCodeState {}

class CommCodeInitial extends CommCodeState {}

class CommCodeLoading extends CommCodeState {}

class CommCodeSuccess extends CommCodeState {
  final CommonCode commonCodes;

  CommCodeSuccess(this.commonCodes);
}

class CommCodeFailure extends CommCodeState {
  final String message;

  CommCodeFailure(this.message);
}
