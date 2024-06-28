import 'package:derbymatch/core/common/widgets/timeSelector/CommonDoubleTimeSelector.dart';
import 'package:derbymatch/features/match/controllers/match_create_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/pallete.dart';
import '../../../../../core/values/values.dart';
import '../../../../core/common/widgets/TableCalendar/common_table_calendar.dart';
import '../../../../core/common/widgets/searchbar/common_search_bar.dart';
import '../../../court/screens/court_select_list_screen.dart';

class MatchCourtFormWidget extends ConsumerStatefulWidget {
  final goNextPage;
  final goPrevPage;

  const MatchCourtFormWidget({
    required this.goNextPage,
    required this.goPrevPage,
    super.key,
  });

  @override
  ConsumerState<MatchCourtFormWidget> createState() =>
      _MatchCourtFormWidgetState();
}

class _MatchCourtFormWidgetState extends ConsumerState<MatchCourtFormWidget>
    with SingleTickerProviderStateMixin {
  late int selectedCourtId;
  late String selectedCourtNm;

  @override
  void initState() {
    super.initState();
    final matchCommand = ref.read(matchCreateProvider);
    selectedCourtId = matchCommand.court_id;
    selectedCourtNm = matchCommand.court_name;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void _courtSearch() async {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CourtSelectListScreen(
            onCourtSelected: (selectedCourtName, selectedCourtIdValue) {
              setState(() {
                selectedCourtNm = selectedCourtName;
                selectedCourtId = selectedCourtIdValue; // 새로운 ID 값을 업데이트
              });
            },
          );
        },
        useSafeArea: false,
      );
    }

    final matchCommand = ref.read(matchCreateProvider);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('매치를 진행할 코트를 고르세요',
                textAlign: TextAlign.left,
                style: AppTextStyles.headlineTextStyle),
            AppSpacesBox.verticalSpaceMedium,
            Container(
              child: InkWell(
                onTap: _courtSearch,
                child: AbsorbPointer(
                  child: CommonSearchBar(
                    hintText: selectedCourtNm ?? '코트를 선택해주세요',
                  ),
                ),
              ),
            ),
            AppSpacesBox.verticalSpaceMedium,
            Expanded(
              child: Container(
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
                          await ref
                              .read(matchCreateProvider.notifier)
                              .editMatchModel(
                                isSave: true,
                                matchCommand: matchCommand.copyWith(
                                  court_id: selectedCourtId,
                                  court_name: selectedCourtNm,
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
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
