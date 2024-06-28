import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/values/values.dart';
import '../commands/comment_filter_command.dart';

final commentFilterProvider =
    StateNotifierProvider<CommentFilterController, CommentFilterCommand>(
  (ref) => CommentFilterController(),
);

class CommentFilterController extends StateNotifier<CommentFilterCommand> {
  CommentFilterController() : super(_initialValue);

  static final _initialValue = CommentFilterCommand(
    post_id: 0,
    page: 0,
    pageSize: 10,
  );

  void setPage(int newPage) {
    state = state.copyWith(page: newPage);
  }

  void setPostId(int newPostId) {
    state = state.copyWith(post_id: newPostId);
  }

  void setPageSize(int newPageSize) {
    state = state.copyWith(pageSize: newPageSize);
  }

  void nextPage() {
    state = state.copyWith(page: state.page + 1);
  }

  void previousPage() {
    if (state.page > 1) {
      state = state.copyWith(page: state.page - 1);
    }
  }

  void resetFilters() {
    state = _initialValue;
  }
}
