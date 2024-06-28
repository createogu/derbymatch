import 'package:derbymatch/features/community/controllers/post_filter_controller.dart';
import 'package:derbymatch/features/community/repositorys/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../auth/models/secure_storage_model.dart';
import '../commands/post_command.dart';
import '../models/post_model.dart';

final postListControllerProvider =
    StateNotifierProvider<PostListController, PostListState>((ref) {
  final postRepository = ref.watch(postRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);
  return PostListController(
    postRepository: postRepository,
    storage: storage,
    ref: ref,
  );
});

class PostListController extends StateNotifier<PostListState> {
  final PostRepository postRepository;
  final FlutterSecureStorage storage;
  final Ref _ref;

  PostListController({
    required this.postRepository,
    required this.storage,
    required Ref ref,
  })  : _ref = ref,
        super(PostListState());

  Future<void> loadPosts() async {
    try {
      state = PostListState(isLoading: true);

      final filter = _ref.read(postFilterProvider);
      final posts = await postRepository.getPostListFiltered(filter);
      state = PostListState(posts: posts);
    } catch (e) {
      state = PostListState(errorMessage: e.toString());
    }
  }

  Future<void> loadMorePosts() async {
    if (state.isLoading || state.isLastPage) return;

    state = state.copyWith(isLoading: true);
    try {
      final filter =
          _ref.read(postFilterProvider).copyWith(page: state.page + 1);
      final morePosts = await postRepository.getPostListFiltered(filter);
      if (morePosts.isEmpty) {
        state = state.copyWith(isLastPage: true);
      } else {
        state = state.copyWith(
          posts: [...state.posts, ...morePosts],
          page: state.page + 1, // 페이지 정보 업데이트
        );
      }
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> fetchPostList() async {
    try {
      state = PostListState(isLoading: true);
      final posts = await postRepository
          .getPostListFiltered(_ref.watch(postFilterProvider));
      state = PostListState(posts: posts);
    } catch (e) {
      state = PostListState(errorMessage: e.toString());
    }
  }

  Future<bool> createPost(PostCommand postCommand) async {
    try {
      final result = await postRepository.createPost(postCommand: postCommand);
      fetchPostList();
      return true;
    } catch (e) {
      state = PostListState(errorMessage: e.toString());
      return false;
    }
  }

  PostModel? getPostInList(int post_id) {
    // state.posts 리스트에서 post_id가 일치하는 포스트를 찾습니다.
    return state.posts.firstWhere((post) => post.post_id == post_id);
  }

  void updatePostInList(PostModel updatedPost) {
    List<PostModel> updatedPosts = state.posts.map((post) {
      return post.post_id == updatedPost.post_id ? updatedPost : post;
    }).toList();
    state = state.copyWith(posts: updatedPosts);
  }
}

class PostListState {
  final List<PostModel> posts;
  final bool isLoading;
  final bool isLastPage;
  final String? errorMessage;
  final int page; // 페이지 정보 추가

  PostListState({
    this.posts = const [],
    this.isLoading = false,
    this.isLastPage = false,
    this.errorMessage,
    this.page = 0, // 초기 페이지를 0으로 설정
  });

  PostListState copyWith({
    List<PostModel>? posts,
    bool? isLoading,
    bool? isLastPage,
    String? errorMessage,
    int? page, // copyWith 메소드에 page 파라미터 추가
  }) {
    return PostListState(
      posts: posts ?? this.posts,
      isLoading: isLoading ?? this.isLoading,
      isLastPage: isLastPage ?? this.isLastPage,
      errorMessage: errorMessage ?? this.errorMessage,
      page: page ?? this.page, // 페이지 값을 업데이트하거나 유지
    );
  }
}
