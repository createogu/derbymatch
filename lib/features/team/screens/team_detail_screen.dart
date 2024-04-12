import 'package:derbymatch/features/team/screens/team_introduction_screen.dart';
import 'package:derbymatch/features/team/screens/team_member_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../../core/theme/pallete.dart';
import '../../../core/values/values.dart';
import '../controllers/TeamController.dart';
import '../models/team_model.dart';

class TeamDetailScreen extends ConsumerStatefulWidget {
  const TeamDetailScreen({super.key});

  @override
  ConsumerState<TeamDetailScreen> createState() => _TeamMainScreenState();
}

class _TeamMainScreenState extends ConsumerState<TeamDetailScreen>
    with SingleTickerProviderStateMixin {
  Future<TeamModel>? teamModel; // late 대신 nullable 타입으로 변경
  int? team_id;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    String? idStr = RouteData.of(context).pathParameters['team_id'];
    if (idStr != null) {
      team_id = int.tryParse(idStr);
      if (team_id != null) {
        teamModel =
            ref.read(TeamControllerProvider.notifier).getTeamDetail(team_id!);
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TeamModel>(
      future: teamModel,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(appBar: AppBar(title: Text('로딩 중...')));
        } else if (snapshot.hasError) {
          return Scaffold(appBar: AppBar(title: Text('에러 발생')));
        } else if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              leadingWidth: 100,
              title: Text(
                snapshot.data!.name, // 팀 이름을 타이틀로 사용
                style: AppTextStyles.titleTextStyle,
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.share),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.settings),
                ),
              ],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(30),
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  tabs: [
                    Tab(text: '홈'),
                    Tab(text: '팀원'),
                    Tab(text: '경기 및 일정'),
                    Tab(text: '통계'),
                    Tab(text: '커뮤니티'),
                  ],
                  indicatorColor: Pallete.primaryColor,
                  labelColor: Pallete.primaryColor,
                  labelStyle: AppTextStyles.bodyTextStyle,
                ),
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                TeamIntroductionScreen(teamModel: snapshot.data!),
                TeamMemberListScreen(team_id: team_id!),
                MatchesScheduleScreen(),
                StatisticsScreen(),
                CommunityScreen(),
              ],
            ),
          );
        } else {
          return Scaffold(appBar: AppBar(title: Text('데이터 없음')));
        }
      },
    );
  }
}

// 기존의 각 탭에 해당하는 스크린 위젯들은 동일하게 유지됩니다.

class TeamMembersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('팀원'),
      ),
    );
  }
}

class MatchesScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('경기 및 일정'),
      ),
    );
  }
}

class StatisticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('통계'),
      ),
    );
  }
}

class SocialFeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('소셜 피드'),
      ),
    );
  }
}

class CommunityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('커뮤니티'),
      ),
    );
  }
}

class TeamInformationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('정보'),
      ),
    );
  }
}
