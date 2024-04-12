import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/court_filter_model.dart';

final courtFilterProvider =
    StateNotifierProvider<CourtFilterController, CourtFilterModel>(
  (ref) => CourtFilterController(),
);

class CourtFilterController extends StateNotifier<CourtFilterModel> {
  CourtFilterController() : super(_initialValue);

  static final _initialValue = CourtFilterModel(
    page: 0,
    pageSize: 10,
    court_type: [],
    court_type_detail: [],
    court_name: '',
    latitude: '',
    longitude: '',
  );

  void updateCourtType(String newCourtType) {
    if (state.court_type.contains(newCourtType)) {
      state = state.copyWith(
          court_type: List.from(state.court_type)..remove(newCourtType));
    } else {
      state = state.copyWith(
          court_type: List.from(state.court_type)..add(newCourtType));
    }
  }

  void updateCourtDetailType(String newCourtDetailType) {
    if (state.court_type_detail.contains(newCourtDetailType)) {
      state = state.copyWith(
          court_type_detail: List.from(state.court_type_detail)
            ..remove(newCourtDetailType));
    } else {
      state = state.copyWith(
          court_type_detail: List.from(state.court_type_detail)
            ..add(newCourtDetailType));
    }
  }

  void setCourtName(String newCourtName) {
    state = state.copyWith(court_name: newCourtName);
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
