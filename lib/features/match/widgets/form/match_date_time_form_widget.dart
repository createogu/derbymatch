import 'package:derbymatch/core/common/widgets/timeSelector/CommonDoubleTimeSelector.dart';
import 'package:derbymatch/features/match/controllers/match_create_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/pallete.dart';
import '../../../../../core/values/values.dart';
import '../../../../core/common/widgets/TableCalendar/common_table_calendar.dart';

class MatchDateTimeFormWidget extends ConsumerStatefulWidget {
  final goNextPage;
  final goPrevPage;

  const MatchDateTimeFormWidget({
    required this.goNextPage,
    required this.goPrevPage,
    super.key,
  });

  @override
  ConsumerState<MatchDateTimeFormWidget> createState() =>
      _MatchDateTimeFormWidgetState();
}

class _MatchDateTimeFormWidgetState
    extends ConsumerState<MatchDateTimeFormWidget>
    with SingleTickerProviderStateMixin {
  late DateTime selectedMatchDate;
  late TimeOfDay selectedStartTime;
  late TimeOfDay selectedEndTime;

  @override
  void initState() {
    super.initState();
    final matchCommand = ref.read(matchCreateProvider);
    selectedStartTime = utils().stringToTimeOfDay(matchCommand.start_time);
    selectedEndTime = utils().stringToTimeOfDay(matchCommand.end_time);
    selectedMatchDate = utils().stringToDate(matchCommand.match_date);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void setStartTime(startTime) {
      setState(() {
        selectedStartTime = startTime;
      });
    }

    void setEndTime(endTime) {
      setState(() {
        selectedEndTime = endTime;
      });
    }

    void handleDaySelected(DateTime day) {
      setState(() {
        selectedMatchDate = day; // 날짜 상태 업데이트
      });
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
            Text('매치 날짜와 시간을 선택해주세요',
                textAlign: TextAlign.left,
                style: AppTextStyles.headlineTextStyle),
            AppSpacesBox.verticalSpaceMedium,
            Container(
              child: CommonTableCalendar(
                focusedDay: selectedMatchDate,
                onDaySelected: handleDaySelected, // 날짜 선택 콜백 전달
              ),
            ),
            AppSpacesBox.verticalSpaceMedium,
            Container(
              child: CommonDoubleTimeSelector(
                selectedStartTime: selectedStartTime,
                selectedEndTime: selectedEndTime,
                setStartTime: setStartTime,
                setEndTime: setEndTime,
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
                                isSave: false,
                                matchCommand: matchCommand.copyWith(
                                  match_date: selectedMatchDate.toString(),
                                  start_time: utils()
                                      .timeOfDayToString(selectedStartTime),
                                  end_time: utils()
                                      .timeOfDayToString(selectedEndTime),
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
