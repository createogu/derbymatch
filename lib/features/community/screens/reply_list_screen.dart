import 'dart:async';

import 'package:derbymatch/features/community/controllers/reply_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/values/values.dart';
import '../../../core/theme/pallete.dart';
import '../widgets/reply_list_card.dart';

class ReplyListScreen extends ConsumerStatefulWidget {
  final int post_id;
  final int comment_id;

  const ReplyListScreen(
      {required this.post_id, required this.comment_id, super.key});

  @override
  ConsumerState<ReplyListScreen> createState() => _ReplyListScreenState();
}

class _ReplyListScreenState extends ConsumerState<ReplyListScreen> {
  final ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialLoadReplys();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _initialLoadReplys() async {
    if (!mounted) return;
    await ref
        .read(replyListControllerProvider.notifier)
        .loadReplys(post_id: widget.post_id, coment_id: widget.comment_id);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !ref.read(replyListControllerProvider).isLoading &&
        !ref.read(replyListControllerProvider).isLastPage) {
      _scrollPosition = _scrollController.position.pixels;
      ref.read(replyListControllerProvider.notifier).loadMoreReplys().then((_) {
        if (mounted) {
          _scrollController.jumpTo(_scrollPosition);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(replyListControllerProvider);
    return Scaffold(
      backgroundColor: Pallete.whiteColor,
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: state.isLoading && state.replys.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount:
                          state.replys.length + (state.isLastPage ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index >= state.replys.length) {
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
                              child: ReplyListCard(reply: state.replys[index]),
                            ),
                            if (index < state.replys.length - 1)
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
