import 'package:derbymatch/core/common/widgets/divider/title_divider.dart';
import 'package:derbymatch/core/values/values.dart';
import 'package:derbymatch/features/team/screens/team_list_screen.dart';
import 'package:derbymatch/features/team/screens/team_my_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/layout/main_screen_layout.dart';

class TeamMainScreen extends ConsumerStatefulWidget {
  const TeamMainScreen({super.key});

  @override
  ConsumerState<TeamMainScreen> createState() => _TeamMainScreenState();
}

class _TeamMainScreenState extends ConsumerState<TeamMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // ElevatedButton(
        //   onPressed: () {
        //     Routemaster.of(context).push('/createTeam');
        //   },
        //   child: Text('팀생성'),
        // ),
        TitleDivider(title: '소속팀'),
        TeamMyListScreen(),
        AppSpacesBox.verticalSpaceMedium,
        TitleDivider(title: '지역 팀 찾기'),
        Expanded(
          flex: 3,
          child: TeamListScreen(),
        ),
      ],
    );
  }
}
