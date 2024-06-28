import 'package:derbymatch/features/community/controllers/reply_controller.dart';
import 'package:derbymatch/features/community/screens/reply_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../../core/layout/view_screen_layout.dart';
import '../../../core/values/values.dart';
import '../widgets/create_reply_widget.dart';
import '../widgets/reply_card.dart';

class ReplyDetailScreen extends ConsumerStatefulWidget {
  const ReplyDetailScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ReplyDetailScreen> createState() => _ReplyDetailScreenState();
}

class _ReplyDetailScreenState extends ConsumerState<ReplyDetailScreen> {
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
            .read(replyControllerProvider(comment_id!).notifier)
            .fetchReplyDetail();
      }
      isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final replyDetailState = ref.watch(replyControllerProvider(comment_id!));

    if (replyDetailState.reply == null) {
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
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ReplyCard(reply: replyDetailState.reply!),
            AppSpacesBox.verticalSpaceXlarge,
          ],
        ),
      ),
      bottomSheet: CreateReplyWidget(
        post_id: post_id!,
        comment_id: comment_id!,
      ),
    );
  }
}
