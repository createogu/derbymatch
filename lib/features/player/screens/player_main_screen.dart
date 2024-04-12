import 'package:carousel_slider/carousel_slider.dart';
import 'package:derbymatch/core/common/widgets/divider/title_divider.dart';
import 'package:derbymatch/features/player/controllers/PlayerController.dart';
import 'package:derbymatch/features/player/models/player_model.dart';
import 'package:derbymatch/features/player/screens/player_list_screen.dart';
import 'package:derbymatch/features/player/widgets/player_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../../core/values/values.dart';
import '../../auth/controllers/user_me_controller.dart';
import '../../auth/models/user_model.dart';

class PlayerMainScreen extends ConsumerStatefulWidget {
  const PlayerMainScreen({super.key});

  @override
  ConsumerState<PlayerMainScreen> createState() => _PlayerMainScreenState();
}

class _PlayerMainScreenState extends ConsumerState<PlayerMainScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userMeProvider) as UserModel;

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
              Routemaster.of(context).push('/createPlayer');
            },
            child: Text('선수생성'),
          ),
          Padding(
            padding: EdgeInsets.all(AppSpaceSize.mediumSize),
            child: TitleDivider(title: '지역 선수 찾기'),
          ),
          Expanded(
            flex: 3,
            child: PlayerListScreen(),
          ),
        ],
      ),
    );
  }
}
