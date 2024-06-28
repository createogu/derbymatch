import 'package:derbymatch/features/community/controllers/post_controller.dart';
import 'package:derbymatch/features/community/controllers/comment_filter_controller.dart';
import 'package:derbymatch/features/community/repositorys/comment_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../auth/models/secure_storage_model.dart';
import '../commands/comment_command.dart';
import '../models/comment_model.dart';

final commentListControllerProvider =
    StateNotifierProvider<CommentListController, CommentListState>((ref) {
  final commentRepository = ref.watch(commentRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);
  return CommentListController(
    commentRepository: commentRepository,
    storage: storage,
    ref: ref,
  );
});

class CommentListController extends StateNotifier<CommentListState> {
  final CommentRepository commentRepository;
  final FlutterSecureStorage storage;
  final Ref _ref;

  CommentListController({
    required this.commentRepository,
    required this.storage,
    required Ref ref,
  })  : _ref = ref,
        super(CommentListState());

  Future<void> loadComments({required int post_id}) async {
    try {
      state = CommentListState(isLoading: true);
      _ref.read(commentFilterProvider.notifier).setPostId(post_id);
      final filter = _ref.read(commentFilterProvider);

      final comments = await commentRepository.getCommentListFiltered(filter);
      state = CommentListState(comments: comments);
    } catch (e) {
      state = CommentListState(errorMessage: e.toString());
    }
  }

  Future<void> loadMoreComments() async {
    if (state.isLoading || state.isLastPage) return;

    state = state.copyWith(isLoading: true);
    try {
      final filter =
          _ref.read(commentFilterProvider).copyWith(page: state.page + 1);
      final moreComments =
          await commentRepository.getCommentListFiltered(filter);
      if (moreComments.isEmpty) {
        state = state.copyWith(isLastPage: true);
      } else {
        state = state.copyWith(
          comments: [...state.comments, ...moreComments],
          page: state.page + 1, // 페이지 정보 업데이트
        );
      }
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> fetchCommentList() async {
    try {
      state = CommentListState(isLoading: true);
      final comments = await commentRepository
          .getCommentListFiltered(_ref.watch(commentFilterProvider));
      state = CommentListState(comments: comments);
    } catch (e) {
      state = CommentListState(errorMessage: e.toString());
    }
  }

  Future<bool> createComment(CommentCommand commentCommand) async {
    try {
      final result =
          await commentRepository.createComment(commentCommand: commentCommand);
      fetchCommentList();
      _ref
          .read(postControllerProvider(commentCommand.post_id).notifier)
          .fetchPostDetail();
      return true;
    } catch (e) {
      state = CommentListState(errorMessage: e.toString());
      return false;
    }
  }

  CommentModel? getCommentInList(int comment_id) {
    // state.posts 리스트에서 post_id가 일치하는 포스트를 찾습니다.
    return state.comments
        .firstWhere((comment) => comment.comment_id == comment_id);
  }

  void updateCommentInList(CommentModel updatedComment) {
    print(updatedComment);
    List<CommentModel> updatedComments = state.comments.map((comment) {
      return comment.comment_id == updatedComment.comment_id
          ? updatedComment
          : comment;
    }).toList();
    state = state.copyWith(comments: updatedComments);
  }
}

class CommentListState {
  final List<CommentModel> comments;
  final bool isLoading;
  final bool isLastPage;
  final String? errorMessage;
  final int page; // 페이지 정보 추가

  CommentListState({
    this.comments = const [],
    this.isLoading = false,
    this.isLastPage = false,
    this.errorMessage,
    this.page = 0, // 초기 페이지를 0으로 설정
  });

  CommentListState copyWith({
    List<CommentModel>? comments,
    bool? isLoading,
    bool? isLastPage,
    String? errorMessage,
    int? page, // copyWith 메소드에 page 파라미터 추가
  }) {
    return CommentListState(
      comments: comments ?? this.comments,
      isLoading: isLoading ?? this.isLoading,
      isLastPage: isLastPage ?? this.isLastPage,
      errorMessage: errorMessage ?? this.errorMessage,
      page: page ?? this.page, // 페이지 값을 업데이트하거나 유지
    );
  }
}
