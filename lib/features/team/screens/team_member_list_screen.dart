import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/pallete.dart';
import '../../../core/values/values.dart';
import '../controllers/TeamController.dart';
import '../models/team_member_model.dart';
import '../widgets/team_member_card.dart'; // 필요한 모델 및 컨트롤러를 임포트하세요

class TeamMemberListScreen extends ConsumerWidget {
  final int team_id;

  const TeamMemberListScreen({required this.team_id, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: FutureBuilder<List<TeamMemberModel>>(
        future: ref
            .read(TeamControllerProvider.notifier)
            .getTeamMemberList(team_id),
        // 여기서 1은 예시 팀 ID입니다.
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('오류: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('팀 멤버가 없습니다.'));
          } else {
            return Column(
              children: [
                AppSpacesBox.verticalSpaceMedium,
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final member = snapshot.data![index];
                      return Column(
                        children: [
                          TeamMemberCard(
                            teamMember: member,
                          ),
                          if (index < snapshot.data!.length - 1)
                            Divider(
                              color: Pallete.greyColor.withOpacity(0.1),
                            ),
                          // 마지막 아이템에는 Divider를 추가하지 않음
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
