import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/controllers/CommCodeController.dart';
import '../../../../core/common/widgets/divider/title_divider.dart';
import '../../../../core/common/widgets/searchbar/common_search_bar.dart';
import '../../../../core/theme/pallete.dart';
import '../../../../core/values/values.dart';
import '../../../court/screens/court_select_list_screen.dart';
import '../../command/team_schedule_info_command.dart';
import '../../controllers/TeamController.dart';

class TeamScheduleInfoFormWidget extends ConsumerStatefulWidget {
  final int team_id;

  const TeamScheduleInfoFormWidget({required this.team_id, super.key});

  @override
  ConsumerState<TeamScheduleInfoFormWidget> createState() =>
      _TeamScheduleInfoFormWidgetState();
}

class _TeamScheduleInfoFormWidgetState
    extends ConsumerState<TeamScheduleInfoFormWidget> {
  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();
  int? selectedCourtId;
  String? selectedCourtNm;
  String selectedDay = '01';

  @override
  void initState() {
    super.initState();
    selectedStartTime = TimeOfDay.now();
    selectedEndTime = TimeOfDay(
      hour: (selectedStartTime.hour + 2) % 24,
      minute: selectedStartTime.minute,
    );
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      barrierLabel: '야야',
      helpText: '${isStartTime ? '시작' : '종료'}시간을 선택해주세요',
      cancelText: '취소',
      confirmText: '선택',
      hourLabelText: '시간',
      minuteLabelText: '분',
      errorInvalidText: '시간을 확인해주세요',
      initialEntryMode: TimePickerEntryMode.inputOnly,
      context: context,
      initialTime: isStartTime ? selectedStartTime : selectedEndTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ref.watch(themeNotifierProvider),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              alwaysUse24HourFormat: false,
            ),
            child: child!,
          ),
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStartTime) {
          selectedStartTime = picked;
          selectedEndTime = utils().addHours(picked, 2);
        } else {
          selectedEndTime = picked;
        }
      });
    }
  }

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

  @override
  Widget build(BuildContext context) {
    final CommCodeController = ref.read(commCodeControllerProvider.notifier);
    List daysList = CommCodeController.getCommCodesByType('days');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '정기모임 등록',
          style: AppTextStyles.headlineTextStyle,
        ),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(AppSpaceSize.mediumSize),
          child: Column(
            children: [
              TitleDivider(title: '요일'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: daysList.map((day) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDay = day.comm_cd;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(AppSpaceSize.mediumSize),
                      decoration: BoxDecoration(
                        color: selectedDay == day.comm_cd
                            ? Pallete.primaryColor
                            : Pallete.whiteColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(day.comm_cd_nm,
                          style: AppTextStyles.bodyTextStyle.copyWith(
                            color: selectedDay == day.comm_cd
                                ? Pallete.whiteColor
                                : Pallete.greyColor,
                          )),
                    ),
                  );
                }).toList(),
              ),
              AppSpacesBox.verticalSpaceLarge,
              TitleDivider(title: '시간'),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () => _selectTime(context, true),
                      child: Column(
                        children: [
                          Text(
                            '시작 시간',
                            style: AppTextStyles.bodyTextStyle,
                          ),
                          Text(
                            '${selectedStartTime.format(context)}',
                            style: AppTextStyles.headlineTextStyle
                                .copyWith(color: Pallete.primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () => _selectTime(context, false),
                      child: Column(
                        children: [
                          Text(
                            '종료 시간',
                            style: AppTextStyles.bodyTextStyle,
                          ),
                          Text(
                            '${selectedEndTime.format(context)}',
                            style: AppTextStyles.headlineTextStyle
                                .copyWith(color: Pallete.primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSpaceSize.largeSize),
              TitleDivider(title: '코트'),
              InkWell(
                onTap: _courtSearch,
                child: AbsorbPointer(
                  child: CommonSearchBar(
                    hintText: selectedCourtNm ?? '코트를 선택해주세요',
                  ),
                ),
              ),
              SizedBox(height: AppSpaceSize.largeSize),
              ElevatedButton(
                onPressed: () async {
                  TeamScheduleInfoCommand scheduleInfoCommand =
                      new TeamScheduleInfoCommand(
                          team_id: widget.team_id,
                          court_id: selectedCourtId!,
                          day_of_week: selectedDay,
                          start_time:
                              utils().formatTimeOfDay(selectedStartTime),
                          end_time: utils().formatTimeOfDay(selectedEndTime));
                  await ref
                      .read(TeamControllerProvider.notifier)
                      .addTeamSchedule(scheduleInfoCommand);
                  Navigator.of(context).pop();
                },
                child: Text(
                  '추가',
                  style: AppTextStyles.bodyTextStyle
                      .copyWith(color: Pallete.whiteColor),
                ),
                style: ButtonStyles.primaryButton,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
