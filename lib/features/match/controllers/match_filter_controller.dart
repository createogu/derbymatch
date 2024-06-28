import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/values/values.dart';
import '../commands/match_filter_command.dart';

final matchFilterProvider =
    StateNotifierProvider<MatchFilterController, MatchFilterCommand>(
  (ref) => MatchFilterController(),
);

class MatchFilterController extends StateNotifier<MatchFilterCommand> {
  MatchFilterController() : super(_initialValue);

  static final _initialValue = MatchFilterCommand(
    page: 0,
    pageSize: 10,
    match_type: [],
    match_date: DateTime.now().toString(),
  );

  void updateMatchType(String newMatchType) {
    if (state.match_type.contains(newMatchType)) {
      state = state.copyWith(
          match_type: List.from(state.match_type)..remove(newMatchType));
    } else {
      state = state.copyWith(
          match_type: List.from(state.match_type)..add(newMatchType));
    }
  }

  void setMatchDate(DateTime matchDate) {
    state = state.copyWith(match_date: utils().dateTimeToString(matchDate));
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
