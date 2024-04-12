import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/player_filter_model.dart';

final playerFilterProvider =
    StateNotifierProvider<PlayerFilterController, PlayerFilterModel>(
  (ref) => PlayerFilterController(),
);

class PlayerFilterController extends StateNotifier<PlayerFilterModel> {
  PlayerFilterController() : super(_initialValue);

  static final _initialValue = PlayerFilterModel(
    gender: [],
    division: [],
    positions: [],
    addressCode: '',
    beginHeight: 150.0,
    endHeight: 220.0,
    beginWeight: 50.0,
    endWeight: 150.0,
    page: 0,
    pageSize: 10,
  );

  void updateGender(String newGender) {
    if (state.gender.contains(newGender)) {
      state =
          state.copyWith(gender: List.from(state.gender)..remove(newGender));
    } else {
      state = state.copyWith(gender: List.from(state.gender)..add(newGender));
    }
  }

  void updateDivision(String newDivision) {
    if (state.division.contains(newDivision)) {
      state = state.copyWith(
          division: List.from(state.division)..remove(newDivision));
    } else {
      state =
          state.copyWith(division: List.from(state.division)..add(newDivision));
    }
  }

  void updatePositions(String newPositions) {
    if (state.positions.contains(newPositions)) {
      state = state.copyWith(
          positions: List.from(state.positions)..remove(newPositions));
    } else {
      state = state.copyWith(
          positions: List.from(state.positions)..add(newPositions));
    }
  }

  void updateAddressCode(String newAddressCode) {
    state = state.copyWith(addressCode: newAddressCode);
  }

  void updateHeightRange(double newBeginHeight, double newEndHeight) {
    state =
        state.copyWith(beginHeight: newBeginHeight, endHeight: newEndHeight);
  }

  void updateWeightRange(double newBeginWeight, double newEndWeight) {
    state =
        state.copyWith(beginWeight: newBeginWeight, endWeight: newEndWeight);
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
