import 'dart:async';

import 'package:derbymatch/features/community/controllers/comment_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/values/values.dart';
import '../../../core/theme/pallete.dart';
import '../widgets/comment_list_card.dart';

class CommentListScreen extends ConsumerStatefulWidget {
  final int post_id;

  const CommentListScreen({required this.post_id, super.key});

  @override
  ConsumerState<CommentListScreen> createState() => _CommentListScreenState();
}

class _CommentListScreenState extends ConsumerState<CommentListScreen> {
  final ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialLoadComments();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _initialLoadComments() async {
    if (!mounted) return;
    await ref
        .read(commentListControllerProvider.notifier)
        .loadComments(post_id: widget.post_id);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !ref.read(commentListControllerProvider).isLoading &&
        !ref.read(commentListControllerProvider).isLastPage) {
      _scrollPosition = _scrollController.position.pixels;
      ref
          .read(commentListControllerProvider.notifier)
          .loadMoreComments()
          .then((_) {
        if (mounted) {
          _scrollController.jumpTo(_scrollPosition);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(commentListControllerProvider);
    return Scaffold(
      backgroundColor: Pallete.whiteColor,
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: state.isLoading && state.comments.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount:
                          state.comments.length + (state.isLastPage ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index >= state.comments.length) {
                          return Padding(
                            padding: EdgeInsets.all(AppSpaceSize.defaultSize),
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
                              child: CommentListCard(
                                  comment: state.comments[index]),
                            ),
                            if (index < state.comments.length - 1)
                              Divider(
                                  color: Pallete.greyColor.withOpacity(0.1)),
                          ],
                        );
                      },
                    ),
            ),
            if (state.errorMessage != null)
              Padding(
                padding: EdgeInsets.all(AppSpaceSize.defaultSize),
                child: Text(state.errorMessage!,
                    style: TextStyle(color: Colors.red)),
              ),
          ],
        ),
      ),
    );
  }
}
