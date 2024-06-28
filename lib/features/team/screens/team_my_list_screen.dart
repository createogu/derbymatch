import 'package:derbymatch/core/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/values/values.dart';
import '../controllers/TeamController.dart';
import '../controllers/TeamFilterController.dart';
import '../models/team_model.dart';
import '../widgets/team_card.dart';
import '../widgets/team_filter_bottom_sheet.dart';

class TeamMyListScreen extends ConsumerStatefulWidget {
  const TeamMyListScreen({super.key});

  @override
  ConsumerState<TeamMyListScreen> createState() => _TeamMyListScreenState();
}

class _TeamMyListScreenState extends ConsumerState<TeamMyListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final myTeamListFuture =
        ref.watch(TeamControllerProvider.notifier).getMyTeamList();
    return FutureBuilder<List<TeamModel>>(
      future: myTeamListFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.data == null || snapshot.data!.isEmpty) {
          return Center(child: Text('No teams found'));
        }
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: snapshot.data!.map((team) {
              return Container(
                width: MediaQuery.of(context).size.width / 1.5,
                child: Padding(
                  padding:
                      EdgeInsets.fromLTRB(0, 0, AppSpaceSize.mediumSize, 0),
                  child: TeamCard(team: team),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
