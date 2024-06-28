import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/widgets/divider/title_divider.dart';
import '../../../../core/theme/pallete.dart';
import '../../../../core/values/values.dart';
import '../../controllers/TeamController.dart';
import '../../models/team_model.dart';

class TeamIntroductionFormWidget extends ConsumerStatefulWidget {
  final TeamModel teamModel;

  const TeamIntroductionFormWidget({
    required this.teamModel,
    super.key,
  });

  @override
  ConsumerState<TeamIntroductionFormWidget> createState() =>
      _TeamIntroductionFormWidgetState();
}

class _TeamIntroductionFormWidgetState
    extends ConsumerState<TeamIntroductionFormWidget> {
  FocusNode textFocus = FocusNode();
  late TextEditingController teamIntroductionEditController;

  @override
  void initState() {
    super.initState();
    teamIntroductionEditController =
        TextEditingController(text: widget.teamModel.introduce);
  }

  @override
  void dispose() {
    teamIntroductionEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '팀 소개 문구 수정',
          style: AppTextStyles.headlineTextStyle,
        ),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(AppSpaceSize.mediumSize),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: TextFormField(
                  controller: teamIntroductionEditController,
                  style: AppTextStyles.infoTextStyle,
                  decoration: AppInputStyles.defaultFormFieldStyle,
                  maxLines: 30,
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    AppSpacesBox.horizontalSpaceMicro,
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () async {
                          await ref
                              .read(TeamControllerProvider.notifier)
                              .editTeamModel(
                                isSave: true,
                                teamModel: widget.teamModel.copyWith(
                                  introduce:
                                      teamIntroductionEditController.text,
                                ),
                              );
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          '저장',
                          style: AppTextStyles.bodyTextStyle
                              .copyWith(color: Pallete.whiteColor),
                        ),
                        style: ButtonStyles.primaryButton,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
