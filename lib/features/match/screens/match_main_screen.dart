import 'package:derbymatch/features/match/screens/match_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/controllers/user_me_controller.dart';
import '../../auth/models/user_model.dart';

class MatchMainScreen extends ConsumerStatefulWidget {
  const MatchMainScreen({super.key});

  @override
  ConsumerState<MatchMainScreen> createState() => _MatchMainScreenState();
}

class _MatchMainScreenState extends ConsumerState<MatchMainScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userMeProvider) as UserModel;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // ElevatedButton(
        //   onPressed: () {
        //     Routemaster.of(context).push('/createMatch');
        //   },
        //   child: Text('매치생성'),
        // ),
        Expanded(
          flex: 3,
          child: MatchListScreen(),
        ),
      ],
    );
  }
}
