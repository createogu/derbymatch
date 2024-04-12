import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/constants/constants.dart';
import '../models/secure_storage_model.dart';
import '../models/user_model.dart';
import '../repositorys/auth_repository.dart';
import '../repositorys/user_me_repository.dart';

final userMeProvider =
    StateNotifierProvider<UserMeStateNotifier, UserModelBase?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final userMeRepository = ref.watch(userMeRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);
  return UserMeStateNotifier(
    authRepository: authRepository,
    repository: userMeRepository,
    storage: storage,
    ref: ref,
  );
});

class UserMeStateNotifier extends StateNotifier<UserModelBase?> {
  final AuthRepository authRepository;
  final UserMeRepository repository;
  final FlutterSecureStorage storage;
  final Ref _ref;

  // UserMeStateNotifier가 관리하는 대상은 UserModelBase로,
  // 맨 처음 UserModelLoading을 넣어주고,
  // async 요청으로 안전저장소에서 토큰을 가져와서 서버에 데이터를 요청 하며
  // 응답이 오면 그 응답을 UserModel로 변환하여 관리대상을 그 값으로 변경

  UserMeStateNotifier({
    required this.authRepository,
    required this.repository,
    required this.storage,
    required Ref ref,
  })  : _ref = ref,
        super(
          UserModelLoading(),
        ) {
    getMe();
  }

  Future<void> getMe() async {
    final tokens = await Future.wait([
      storage.read(key: refreshTokenKey),
      storage.read(key: accessTokenKey),
    ]);
    final refreshToken = tokens[0];
    final accessToken = tokens[1];

    if (refreshToken == null || accessToken == null) {
      //만약 둘 중 하나의 값이 없으면 로그인을 해야 하므로 null로 변환
      state = null;
      return;
    }

    final resp = await repository.getMe();

    state = resp;
  }

  Future<UserModelBase> login({
    required String kakao_access_token,
    // required String password,
  }) async {
    try {
      state = UserModelLoading();

      final resp = await authRepository.login(
        kakao_access_token: kakao_access_token,
      );

      await Future.wait([
        storage.write(key: refreshTokenKey, value: resp.refreshToken),
        storage.write(key: accessTokenKey, value: resp.accessToken),
      ]);
      final userResp = await repository.getMe();

      state = userResp;
    } catch (e) {
      print(e);
      state = UserModelError(errorMessage: '로그인에 실패했습니다.');
    }
    return Future.value(state);
  }

  Future<UserModel> editUserModel({
    required UserModel userModel,
    required bool isSave,
  }) async {
    if (isSave) {
      final resp = await repository.editUserModel(
        userModel: userModel,
      );
      userModel = resp;
    }
    state = userModel;

    return userModel;
  }

  Future<void> logout() async {
    state = null;

    await Future.wait([
      storage.delete(key: refreshTokenKey),
      storage.delete(key: accessTokenKey),
    ]);
  }
}
