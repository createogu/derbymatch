import 'package:derbymatch/core/values/values.dart';
import 'package:derbymatch/features/auth/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/widgets/selectAddress/widgets/search_address_bar_widget.dart';
import '../../auth/controllers/user_me_controller.dart';
import '../../match/screens/today_quick_match_list.dart';

class HomeMainScreen extends ConsumerStatefulWidget {
  const HomeMainScreen({super.key});

  @override
  ConsumerState<HomeMainScreen> createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends ConsumerState<HomeMainScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userMeProvider) as UserModel;
    List<BasketballMatch> getDummyMatches() {
      List<BasketballMatch> matches = [];

      // 픽업게임 더미 데이터 생성
      for (int i = 1; i <= 5; i++) {
        matches.add(BasketballMatch(
          team1: '팀 $i',
          team2: '팀 ${i + 5}',
          matchTime: '2024-04-${i + 10} 18:00',
          type: '픽업게임',
        ));
      }

      // 게스트 모집 더미 데이터 생성
      for (int i = 1; i <= 5; i++) {
        matches.add(BasketballMatch(
          team1: '팀 ${i + 10}',
          team2: '팀 ${i + 15}',
          matchTime: '2024-04-${i + 15} 20:00',
          type: '게스트 모집',
        ));
      }

      return matches;
    }

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 150,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpaceSize.mediumSize),
          child: Text(
            'HOME',
            style: AppTextStyles.titleTextStyle,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSpaceSize.mediumSize),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchAddressBar(user: user),
              AppSpacesBox.verticalSpaceMedium,
              SizedBox(
                height: 250, // 고정된 높이 설정
                width: double.infinity,
                child: TodayQuickMatchList(
                  matches: getDummyMatches(),
                ),
              ),
              // 여기에 다른 위젯들을 추가할 수 있습니다.
            ],
          ),
        ),
      ),
    );
  }
}
