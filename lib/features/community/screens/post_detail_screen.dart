import 'package:derbymatch/features/community/controllers/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../../core/layout/view_screen_layout.dart';
import '../widgets/create_comment_widget.dart';
import 'comment_list_screen.dart';

class PostDetailScreen extends ConsumerStatefulWidget {
  const PostDetailScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends ConsumerState<PostDetailScreen> {
  int? post_id;
  bool isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInitialized) {
      final routeData = RouteData.of(context);
      post_id = int.tryParse(routeData.pathParameters['post_id'] ?? '');
      if (post_id != null) {
        ref.read(postControllerProvider(post_id!).notifier).fetchPostDetail();
      }
      isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final postDetailState = ref.watch(postControllerProvider(post_id!));

    if (postDetailState.post == null) {
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
      child: CommentListScreen(
        post_id: post_id!,
      ),
      bottomSheet: CreateCommentWidget(
        post_id: post_id!,
      ),
    );
  }
}
