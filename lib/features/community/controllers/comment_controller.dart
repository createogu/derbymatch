import 'package:derbymatch/features/community/models/comment_model.dart';
import 'package:derbymatch/features/community/repositorys/comment_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'comment_list_controller.dart';

final commentControllerProvider =
    StateNotifierProvider.family<CommentController, CommentDetailState, int>((
  ref,
  comment_id,
) {
  final commentRepository = ref.watch(commentRepositoryProvider);
  return CommentController(
    commentRepository: commentRepository,
    comment_id: comment_id,
    ref: ref,
  );
});

class CommentController extends StateNotifier<CommentDetailState> {
  final CommentRepository commentRepository;
  final int comment_id;
  final Ref _ref;

  CommentController({
    required this.commentRepository,
    required this.comment_id,
    required Ref ref,
  })  : _ref = ref,
        super(CommentDetailState());

  Future<void> fetchCommentDetail() async {
    _updateCommentState(await _safeApiCall(
        () => commentRepository.getCommentDetail(comment_id)));
  }

  void _updateCommentState(CommentModel? comment) {
    if (comment != null) {
      state = CommentDetailState(comment: comment);
      _ref
          .read(commentListControllerProvider.notifier)
          .updateCommentInList(state.comment!);
    } else {
      state =
          CommentDetailState(errorMessage: 'Failed to fetch Comment details.');
    }
  }

  Future<CommentModel?> _safeApiCall(
      Future<CommentModel?> Function() apiCall) async {
    try {
      return await apiCall();
    } catch (e) {
      state = CommentDetailState(errorMessage: e.toString());
      return null;
    }
  }

  Future<bool> updateComment(CommentModel updatedComment) async {
    try {
      final result = await commentRepository.editCommentModel(
          commentModel: updatedComment);
      state = CommentDetailState(comment: result);
      return true;
    } catch (e) {
      state = CommentDetailState(errorMessage: e.toString());
      return false;
    }
  }

  Future<bool> toggleLike() async {
    if (state.comment == null) {
      state = CommentDetailState(
          comment: await _ref
              .read(commentListControllerProvider.notifier)
              .getCommentInList(comment_id));
    }
    return await _updateLikeState();
  }

  Future<bool> _updateLikeState() async {
    try {
      await commentRepository.commentToggleLike(comment_id: comment_id);
      var newLikeState = !state.comment!.is_like;
      var newLikeCount = state.comment!.like_cnt + (newLikeState ? 1 : -1);
      state = CommentDetailState(
        comment: state.comment?.copyWith(
          is_like: newLikeState,
          like_cnt: newLikeCount,
        ),
      );
      _ref
          .read(commentListControllerProvider.notifier)
          .updateCommentInList(state.comment!);
      return true;
    } catch (e) {
      state = CommentDetailState(errorMessage: e.toString());
      return false;
    }
  }
}

class CommentDetailState {
  final CommentModel? comment;
  final String? errorMessage;

  CommentDetailState({this.comment, this.errorMessage});
}
