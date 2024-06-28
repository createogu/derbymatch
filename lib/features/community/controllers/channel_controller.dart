import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../auth/models/secure_storage_model.dart';
import '../models/channel_model.dart';
import '../repositorys/channel_repository.dart';

final channelControllerProvider =
    StateNotifierProvider<ChannelStateNotifier, ChannelState>((ref) {
  final channelRepository = ref.watch(channelRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);

  return ChannelStateNotifier(
    channelRepository: channelRepository,
    storage: storage,
    ref: ref,
  );
});

class ChannelStateNotifier extends StateNotifier<ChannelState> {
  final ChannelRepository channelRepository;
  final FlutterSecureStorage storage;
  final Ref _ref;

  ChannelStateNotifier({
    required this.channelRepository,
    required this.storage,
    required Ref ref,
  })  : _ref = ref,
        super(ChannelInitial()) {}

  Future<List<ChannelModel>> getMyChannelList() async {
    try {
      // channelRepository에서 filterModel을 사용하여 필터링된 플레이어 목록을 조회
      // 페이지 정보도 함께 전달합니다.

      final response = await channelRepository.getMyChannelList();
      // 상태 업데이트 (조회 성공)
      state = ChannelSuccess(response);
      print(response);
      // 서버 응답 반환
      return response;
    } catch (e) {
      // 상태 업데이트 (조회 실패)
      state = ChannelFailure("조회 중 에러: $e");

      // 예외 발생시, 해당 예외를 다시 던짐
      throw e;
    }
  }
}

// 파일 업로드 상태를 나타내는 클래스
abstract class ChannelState {}

class ChannelInitial extends ChannelState {}

class ChannelLoading extends ChannelState {}

class ChannelSuccess extends ChannelState {
  final dynamic data;

  ChannelSuccess(this.data);
}

class ChannelFailure extends ChannelState {
  final String message;

  ChannelFailure(this.message);
}
