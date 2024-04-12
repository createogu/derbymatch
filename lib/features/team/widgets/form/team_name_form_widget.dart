import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/widgets/label_with_form_field.dart';
import '../../../../core/theme/pallete.dart';
import '../../../../core/values/values.dart';
import '../../controllers/TeamCreateController.dart';

class TeamNameFormWidget extends ConsumerStatefulWidget {
  final VoidCallback goNextPage;
  final VoidCallback goPrevPage;

  const TeamNameFormWidget({
    required this.goNextPage,
    required this.goPrevPage,
    super.key,
  });

  @override
  ConsumerState<TeamNameFormWidget> createState() => _TeamNameFormWidgetState();
}

class _TeamNameFormWidgetState extends ConsumerState<TeamNameFormWidget> {
  FocusNode textFocus = FocusNode();
  late TextEditingController teamNameEditController;

  @override
  void initState() {
    super.initState();
    // 여기에서 초기 값을 설정합니다.
    teamNameEditController = TextEditingController();
  }

  @override
  void dispose() {
    teamNameEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final teamModel = ref.read(teamCreateProvider);
    teamNameEditController.text = teamModel.name;

    return GestureDetector(
      onTap: () => textFocus.unfocus(),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: LabelWithFormField(
                controller: teamNameEditController,
                label: '팀 이름을 작성해주세요',
                keyboardType: 'text',
                placeholder: '불쾌감을 주는 이름은 안돼요!',
                obscureText: false,
                textFocus: textFocus,
              ),
            ),
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () async {
                        textFocus.unfocus();
                        await ref
                            .read(teamCreateProvider.notifier)
                            .editTeamModel(
                              teamModel: teamModel.copyWith(
                                  name: teamNameEditController.text),
                              isSave: false,
                            );
                        widget.goNextPage();
                      },
                      child: Text(
                        "다음",
                        style: AppTextStyles.bodyTextStyle
                            .copyWith(color: Pallete.whiteColor),
                      ),
                      style: ButtonStyles.primaryButton,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSpaceSize.xlargeSize),
          ],
        ),
      ),
    );
  }
}
