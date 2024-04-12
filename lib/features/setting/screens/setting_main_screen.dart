import 'package:derbymatch/features/profile/widgets/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/widgets/list/labelled_option_list_item.dart';
import '../../../core/values/values.dart';
import '../../auth/controllers/user_me_controller.dart';
import '../../auth/models/user_model.dart';

class SettingMainScreen extends ConsumerWidget {
  const SettingMainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(userMeProvider) as UserModel;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 200,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpaceSize.mediumSize),
          child: Text(
            'MY',
            style: AppTextStyles.titleTextStyle,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSpaceSize.mediumSize),
        child: ListView(
          children: [
            ProfileCard(userModel: user),
            AppSpacesBox.verticalSpaceMedium,
            LabelledOptionListItem(label: '경기기록', icon: Icons.history),
            LabelledOptionListItem(
                label: 'Mark all completed', icon: Icons.check_circle),
            LabelledOptionListItem(
                label: 'Copy', icon: Icons.tag, link: "taskez.io/6734aw"),
            LabelledOptionListItem(
                label: 'Duplicate Project', icon: Icons.fiber_smart_record),
            LabelledOptionListItem(
              label: 'Set Color',
              icon: Icons.color_lens,
              boxColor: "FFDE72",
            ),
            LabelledOptionListItem(
                label: 'Archive Project',
                icon: Icons.archive,
                color: HexColor.fromHex("C55FFF")),
            LabelledOptionListItem(
                label: 'Delect Project',
                icon: Icons.cancel_presentation_sharp,
                color: HexColor.fromHex("FC958E")),
          ],
        ),
      ),
    );
  }
}
