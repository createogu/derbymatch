import 'package:derbymatch/features/community/controllers/post_list_controller.dart';
import 'package:derbymatch/features/community/models/post_model.dart';
import 'package:derbymatch/features/community/repositorys/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postControllerProvider =
    StateNotifierProvider.family<PostController, PostDetailState, int>(
        (ref, post_id) {
  final postRepository = ref.watch(postRepositoryProvider);
  return PostController(
    postRepository: postRepository,
    post_id: post_id,
    ref: ref,
  );
});

class PostController extends StateNotifier<PostDetailState> {
  final PostRepository postRepository;
  final int post_id;
  final Ref _ref;

  PostController({
    required this.postRepository,
    required this.post_id,
    required Ref ref,
  })  : _ref = ref,
        super(PostDetailState());

  Future<void> fetchPostDetail() async {
    _updatePostState(
        await _safeApiCall(() => postRepository.getPostDetail(post_id)));
  }

  void _updatePostState(PostModel? post) {
    if (post != null) {
      state = PostDetailState(post: post);
      _ref
          .read(postListControllerProvider.notifier)
          .updatePostInList(state.post!);
    } else {
      state = PostDetailState(errorMessage: 'Failed to fetch post details.');
    }
  }

  Future<PostModel?> _safeApiCall(Future<PostModel?> Function() apiCall) async {
    try {
      return await apiCall();
    } catch (e) {
      state = PostDetailState(errorMessage: e.toString());
      return null;
    }
  }

  Future<bool> toggleLike() async {
    if (state.post == null) {
      state = PostDetailState(
          post: await _ref
              .read(postListControllerProvider.notifier)
              .getPostInList(post_id));
    }
    return await _updateLikeState();
  }

  Future<bool> _updateLikeState() async {
    try {
      await postRepository.postToggleLike(post_id: post_id);
      var newLikeState = !state.post!.is_like;
      var newLikeCount = state.post!.like_cnt + (newLikeState ? 1 : -1);
      state = PostDetailState(
        post: state.post?.copyWith(
          is_like: newLikeState,
          like_cnt: newLikeCount,
        ),
      );
      _ref
          .read(postListControllerProvider.notifier)
          .updatePostInList(state.post!);
      return true;
    } catch (e) {
      state = PostDetailState(errorMessage: e.toString());
      return false;
    }
  }
}

class PostDetailState {
  final PostModel? post;
  final String? errorMessage;

  PostDetailState({this.post, this.errorMessage});
}
