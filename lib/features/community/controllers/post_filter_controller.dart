import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/values/values.dart';
import '../commands/post_filter_command.dart';

final postFilterProvider =
    StateNotifierProvider<PostFilterController, PostFilterCommand>(
  (ref) => PostFilterController(),
);

class PostFilterController extends StateNotifier<PostFilterCommand> {
  PostFilterController() : super(_initialValue);

  static final _initialValue = PostFilterCommand(
    page: 0,
    pageSize: 10,
    channels: [],
  );

  void updateChannels(int newChannel) {
    print(newChannel);
    if (state.channels.contains(newChannel)) {
      state = state.copyWith(
          channels: List.from(state.channels)..remove(newChannel));
    } else {
      state =
          state.copyWith(channels: List.from(state.channels)..add(newChannel));
    }
  }

  void setPage(int newPage) {
    state = state.copyWith(page: newPage);
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
