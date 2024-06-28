import 'package:derbymatch/features/community/controllers/post_controller.dart';
import 'package:derbymatch/features/community/controllers/reply_filter_controller.dart';
import 'package:derbymatch/features/community/repositorys/reply_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../auth/models/secure_storage_model.dart';
import '../commands/reply_command.dart';
import '../models/reply_model.dart';
import 'comment_controller.dart';

final replyListControllerProvider =
    StateNotifierProvider<ReplyListController, ReplyListState>((ref) {
  final replyRepository = ref.watch(replyRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);
  return ReplyListController(
    replyRepository: replyRepository,
    storage: storage,
    ref: ref,
  );
});

class ReplyListController extends StateNotifier<ReplyListState> {
  final ReplyRepository replyRepository;
  final FlutterSecureStorage storage;
  final Ref _ref;

  ReplyListController({
    required this.replyRepository,
    required this.storage,
    required Ref ref,
  })  : _ref = ref,
        super(ReplyListState());

  Future<void> loadReplys(
      {required int post_id, required int coment_id}) async {
    try {
      state = ReplyListState(isLoading: true);
      _ref.read(replyFilterProvider.notifier).setPostId(post_id);
      _ref.read(replyFilterProvider.notifier).setCommentId(coment_id);
      final filter = await _ref.read(replyFilterProvider);

      final replys = await replyRepository.getReplyListFiltered(filter);
      state = ReplyListState(replys: replys);
    } catch (e) {
      state = ReplyListState(errorMessage: e.toString());
    }
  }

  Future<void> loadMoreReplys() async {
    if (state.isLoading || state.isLastPage) return;

    state = state.copyWith(isLoading: true);
    try {
      final filter =
          _ref.read(replyFilterProvider).copyWith(page: state.page + 1);
      final moreReplys = await replyRepository.getReplyListFiltered(filter);
      if (moreReplys.isEmpty) {
        state = state.copyWith(isLastPage: true);
      } else {
        state = state.copyWith(
          replys: [...state.replys, ...moreReplys],
          page: state.page + 1, // 페이지 정보 업데이트
        );
      }
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> fetchReplyList() async {
    try {
      state = ReplyListState(isLoading: true);
      final replys = await replyRepository
          .getReplyListFiltered(_ref.watch(replyFilterProvider));
      state = ReplyListState(replys: replys);
    } catch (e) {
      state = ReplyListState(errorMessage: e.toString());
    }
  }

  Future<bool> createReply(ReplyCommand replyCommand) async {
    try {
      final result =
          await replyRepository.createReply(replyCommand: replyCommand);
      print(result);
      fetchReplyList();
      _ref
          .read(commentControllerProvider(replyCommand.comment_id!).notifier)
          .fetchCommentDetail();
      return true;
    } catch (e) {
      state = ReplyListState(errorMessage: e.toString());
      return false;
    }
  }
}

class ReplyListState {
  final List<ReplyModel> replys;
  final bool isLoading;
  final bool isLastPage;
  final String? errorMessage;
  final int page; // 페이지 정보 추가

  ReplyListState({
    this.replys = const [],
    this.isLoading = false,
    this.isLastPage = false,
    this.errorMessage,
    this.page = 0, // 초기 페이지를 0으로 설정
  });

  ReplyListState copyWith({
    List<ReplyModel>? replys,
    bool? isLoading,
    bool? isLastPage,
    String? errorMessage,
    int? page, // copyWith 메소드에 page 파라미터 추가
  }) {
    return ReplyListState(
      replys: replys ?? this.replys,
      isLoading: isLoading ?? this.isLoading,
      isLastPage: isLastPage ?? this.isLastPage,
      errorMessage: errorMessage ?? this.errorMessage,
      page: page ?? this.page, // 페이지 값을 업데이트하거나 유지
    );
  }
}
