import 'dart:async';

import 'package:derbymatch/features/community/controllers/post_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../../../core/values/values.dart';
import '../../../core/theme/pallete.dart';
import '../widgets/post_list_card.dart';

class PostListScreen extends ConsumerStatefulWidget {
  const PostListScreen({super.key});

  @override
  ConsumerState<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends ConsumerState<PostListScreen> {
  final ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0; // 스크롤 위치 저장을 위한 변수

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    Future.microtask(() => _initialLoadPosts());
  }

  Future<void> _initialLoadPosts() async {
    await ref.read(postListControllerProvider.notifier).loadPosts();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !ref.read(postListControllerProvider).isLoading &&
        !ref.read(postListControllerProvider).isLastPage) {
      _scrollPosition = _scrollController.position.pixels; // 스크롤 위치 저장
      ref.read(postListControllerProvider.notifier).loadMorePosts().then((_) {
        _scrollController.jumpTo(_scrollPosition); // 스크롤 위치 복원
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(postListControllerProvider);
    return Scaffold(
      backgroundColor: Pallete.whiteColor,
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: state.isLoading && state.posts.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount:
                          state.posts.length + (state.isLastPage ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index >= state.posts.length) {
                          return Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(
                              child: Text("마지막 글 입니다."),
                            ),
                          );
                        }
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: AppSpaceSize.smallSize),
                              child: PostListCard(post: state.posts[index]),
                            ),
                            if (index < state.posts.length - 1)
                              Divider(
                                  color: Pallete.greyColor.withOpacity(0.1)),
                          ],
                        );
                      },
                    ),
            ),
            if (state.errorMessage != null)
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(state.errorMessage!,
                    style: TextStyle(color: Colors.red)),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Routemaster.of(context).push('/community/create');
        },
        backgroundColor: Pallete.primaryColor,
        child: Icon(Icons.add, size: 28, color: Pallete.whiteColor),
        elevation: 5.0,
        // 그림자의 높이를 조절하여 3D 효과 부여
        shape: CircleBorder(
            side: BorderSide(color: Pallete.whiteColor, width: 3) // 테두리 추가
            ),
      ),
    );
  }
}
