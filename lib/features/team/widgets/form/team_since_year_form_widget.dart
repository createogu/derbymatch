import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/common/widgets/label_with_form_field.dart';
import '../../../../../core/theme/pallete.dart';
import '../../../../../core/values/values.dart';
import '../../controllers/TeamCreateController.dart';

class TeamSinceYearFormWidget extends ConsumerStatefulWidget {
  final VoidCallback goNextPage;
  final VoidCallback goPrevPage;

  const TeamSinceYearFormWidget({
    required this.goNextPage,
    required this.goPrevPage,
    super.key,
  });

  @override
  ConsumerState<TeamSinceYearFormWidget> createState() =>
      _TeamNameFormWidgetState();
}

class _TeamNameFormWidgetState extends ConsumerState<TeamSinceYearFormWidget> {
  int since_year = 2024;

  @override
  void initState() {
    super.initState();
    final teamModel = ref.read(teamCreateProvider);
    since_year = teamModel.since_year;
    // 여기에서 초기 값을 설정합니다.
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final teamModel = ref.read(teamCreateProvider);

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text('${teamModel.name}팀의\n설립년도는 언제 인가요?',
                textAlign: TextAlign.left,
                style: AppTextStyles.headlineTextStyle),
          ),
          Expanded(
            flex: 1,
            child: Text('${since_year.toString()}년',
                textAlign: TextAlign.center,
                style: AppTextStyles.titleTextStyle),
          ),
          Expanded(
              flex: 3,
              child: Container(
                child: Slider(
                  value: since_year.toDouble(),
                  min: 1980,
                  max: 2024,
                  divisions: 44,
                  // 2024 - 1900
                  label: since_year.toString(),
                  onChanged: (double value) {
                    setState(() {
                      since_year = value.toInt();
                    });
                  },
                ),
              )),
          Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: TextButton(
                    onPressed: () {
                      widget.goPrevPage();
                    },
                    child: Text("이전",
                        style: AppTextStyles.bodyTextStyle
                            .copyWith(color: Pallete.primaryColor)),
                    style: ButtonStyles.seconderyButton,
                  ),
                ),
                AppSpacesBox.horizontalSpaceSmall,
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () async {
                      await ref.read(teamCreateProvider.notifier).editTeamModel(
                            isSave: false,
                            teamModel: teamModel.copyWith(
                              since_year: since_year,
                            ),
                          );
                      widget.goNextPage();
                    },
                    child: Text(
                      // profileStep.length == currentPage + 1 ? "완료" :
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
          SizedBox(
            height: AppSpaceSize.xlargeSize,
          ),
        ],
      ),
    );
  }
}
