import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../auth/models/secure_storage_model.dart';
import '../models/team_model.dart';
import '../repositorys/TeamRepository.dart';

final teamCreateProvider = StateNotifierProvider<TeamController, TeamModel>(
  (ref) {
    final teamRepository = ref.watch(teamRepositoryProvider);
    final storage = ref.watch(secureStorageProvider);
    return TeamController(
      teamRepository: teamRepository,
      storage: storage,
      ref: ref,
    );
  },
);

class TeamController extends StateNotifier<TeamModel> {
  final TeamRepository teamRepository;
  final FlutterSecureStorage storage;
  final Ref _ref;

  TeamController({
    required this.teamRepository,
    required this.storage,
    required Ref ref,
  })  : _ref = ref,
        super(_initialValue);

  static final _initialValue = TeamModel(
    team_id: 0,
    name: '',
    team_logo_image: '',
    since_year: 2024,
    division: '',
    addressCode: '',
    addressName: '',
    introduce: '',
  );

  Future<TeamModel> editTeamModel({
    required TeamModel teamModel,
    required bool isSave,
  }) async {
    if (isSave) {
      if (teamModel.team_id != 0) {
        final resp = await teamRepository.editTeamModel(
          teamModel: teamModel,
        );
        teamModel = resp;
      } else {
        final resp = await teamRepository.createTeamModel(
          teamModel: teamModel,
        );
        teamModel = resp;
      }
    }
    // 항상 상태를 업데이트하도록 변경합니다.
    state = teamModel; // `TeamSuccess` 상태로 `teamModel`을 포장합니다.

    return teamModel;
  }
}
