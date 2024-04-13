import 'package:derbymatch/features/match/commands/match_command.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../auth/models/secure_storage_model.dart';
import '../repositorys/match_repository.dart';

final matchCreateProvider =
    StateNotifierProvider<MatchCreateController, MatchCommand>(
  (ref) {
    final matchRepository = ref.watch(matchRepositoryProvider);
    final storage = ref.watch(secureStorageProvider);
    return MatchCreateController(
      matchRepository: matchRepository,
      storage: storage,
      ref: ref,
    );
  },
);

class MatchCreateController extends StateNotifier<MatchCommand> {
  final MatchRepository matchRepository;
  final FlutterSecureStorage storage;
  final Ref _ref;

  MatchCreateController({
    required this.matchRepository,
    required this.storage,
    required Ref ref,
  })  : _ref = ref,
        super(_initialValue);

  static final _initialValue = MatchCommand(
    match_id: 0,
    match_type: '01',
    match_date: DateTime.now().toString(),
    start_time: '00:00',
    end_time: '02:00',
    court_id: 0,
    organizer_id: 0,
    status: '01',
  );

  Future<MatchCommand> editMatchModel({
    required MatchCommand matchCommand,
    required bool isSave,
  }) async {
    if (isSave) {
      final resp = await matchRepository.createMatchModel(
        matchCommand: matchCommand,
      );
    }
    // 항상 상태를 업데이트하도록 변경합니다.
    state = matchCommand; // `MatchSuccess` 상태로 `matchModel`을 포장합니다.

    return matchCommand;
  }
}
