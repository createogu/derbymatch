import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/team_filter_model.dart';

final teamFilterProvider =
    StateNotifierProvider<TeamFilterController, TeamFilterModel>(
  (ref) => TeamFilterController(),
);

class TeamFilterController extends StateNotifier<TeamFilterModel> {
  TeamFilterController() : super(_initialValue);

  static final _initialValue = TeamFilterModel(
    division: [],
    addressCode: '',
    page: 0,
    pageSize: 10,
  );

  void updateDivision(String newDivision) {
    if (state.division.contains(newDivision)) {
      state = state.copyWith(
          division: List.from(state.division)..remove(newDivision));
    } else {
      state =
          state.copyWith(division: List.from(state.division)..add(newDivision));
    }
  }

  void updateAddressCode(String newAddressCode) {
    state = state.copyWith(addressCode: newAddressCode);
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
