import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/values/values.dart';
import '../../auth/controllers/user_me_controller.dart';
import '../../auth/models/user_model.dart';
import '../widgets/court_filter_bar.dart';
import 'court_list_screen.dart';

class CourtMainScreen extends ConsumerStatefulWidget {
  const CourtMainScreen({super.key});

  @override
  ConsumerState<CourtMainScreen> createState() => _CourtMainScreenState();
}

class _CourtMainScreenState extends ConsumerState<CourtMainScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userMeProvider) as UserModel;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 120,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpaceSize.mediumSize),
          child: Text(
            'COURT',
            style: AppTextStyles.titleTextStyle,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: CourtListScreen(),
          ),
        ],
      ),
    );
  }
}
