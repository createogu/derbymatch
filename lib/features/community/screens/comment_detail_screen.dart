import 'package:derbymatch/features/community/controllers/comment_controller.dart';
import 'package:derbymatch/features/community/screens/reply_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../../core/layout/view_screen_layout.dart';
import '../../../core/values/values.dart';
import '../widgets/comment_card.dart';
import '../widgets/create_reply_widget.dart';
import 'comment_list_screen.dart';

class CommentDetailScreen extends ConsumerStatefulWidget {
  const CommentDetailScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CommentDetailScreen> createState() =>
      _CommentDetailScreenState();
}

class _CommentDetailScreenState extends ConsumerState<CommentDetailScreen> {
  int? post_id;
  int? comment_id;

  bool isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInitialized) {
      final routeData = RouteData.of(context);
      post_id = int.tryParse(routeData.pathParameters['post_id'] ?? '');
      comment_id = int.tryParse(routeData.pathParameters['comment_id'] ?? '');
      if (comment_id != null) {
        ref
            .read(commentControllerProvider(comment_id!).notifier)
            .fetchCommentDetail();
      }
      isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final commentDetailState =
        ref.watch(commentControllerProvider(comment_id!));

    if (commentDetailState.comment == null) {
      return ViewScreenLayout(
        canRegister: false,
        onRegister: () {},
        title: 'Loading...',
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return ViewScreenLayout(
      canRegister: false,
      onRegister: () {},
      title: '',
      child: ReplyListScreen(
        post_id: post_id!,
        comment_id: comment_id!,
      ),
      bottomSheet: CreateReplyWidget(
        post_id: post_id!,
        comment_id: comment_id!,
      ),
    );
  }
}
