import 'package:carousel_slider/carousel_slider.dart';
import 'package:derbymatch/core/common/widgets/divider/title_divider.dart';
import 'package:derbymatch/features/team/controllers/TeamController.dart';
import 'package:derbymatch/features/team/models/team_model.dart';
import 'package:derbymatch/features/team/screens/team_list_screen.dart';
import 'package:derbymatch/features/team/widgets/team_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../../core/values/values.dart';
import '../../auth/controllers/user_me_controller.dart';
import '../../auth/models/user_model.dart';

class TeamMainScreen extends ConsumerStatefulWidget {
  const TeamMainScreen({super.key});

  @override
  ConsumerState<TeamMainScreen> createState() => _TeamMainScreenState();
}

class _TeamMainScreenState extends ConsumerState<TeamMainScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userMeProvider) as UserModel;
    final myTeamListFuture =
        ref.read(TeamControllerProvider.notifier).getMyTeamList();

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpaceSize.mediumSize),
          child: Text(
            'TEAM',
            style: AppTextStyles.titleTextStyle,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: () {
              Routemaster.of(context).push('/createTeam');
            },
            child: Text('팀생성'),
          ),
          Padding(
            padding: EdgeInsets.all(AppSpaceSize.mediumSize),
            child: TitleDivider(title: '소속팀'),
          ),
          Container(
            child: FutureBuilder(
              future: myTeamListFuture,
              builder: (context, AsyncSnapshot<List<TeamModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (snapshot.data == null || snapshot.data!.isEmpty) {
                  return Text('팀이 없습니다');
                }
                List<TeamModel> myTeamList = snapshot.data!;
                return Wrap(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 100,
                        autoPlay: false,
                        aspectRatio: 2,
                        enlargeCenterPage: false,
                        enableInfiniteScroll: false,
                      ),
                      items: myTeamList.map((team) {
                        return Builder(
                          builder: (BuildContext context) {
                            return TeamCard(team: team);
                          },
                        );
                      }).toList(),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(AppSpaceSize.mediumSize),
            child: TitleDivider(title: '지역 팀 찾기'),
          ),
          Expanded(
            flex: 3,
            child: TeamListScreen(),
          ),
        ],
      ),
    );
  }
}
