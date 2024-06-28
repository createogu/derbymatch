import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/pallete.dart';
import '../../../values/values.dart';

class CommonDoubleTimeSelector extends ConsumerStatefulWidget {
  final TimeOfDay selectedStartTime;
  final TimeOfDay selectedEndTime;
  final Function setStartTime;
  final Function setEndTime;

  const CommonDoubleTimeSelector(
      {required this.selectedStartTime,
      required this.selectedEndTime,
      required this.setStartTime,
      required this.setEndTime,
      super.key});

  @override
  ConsumerState<CommonDoubleTimeSelector> createState() =>
      _CommonDoubleTimeSelectorState();
}

class _CommonDoubleTimeSelectorState
    extends ConsumerState<CommonDoubleTimeSelector> {
  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      helpText: '${isStartTime ? '시작' : '종료'}시간을 선택해주세요',
      cancelText: '취소',
      confirmText: '선택',
      hourLabelText: '시간',
      minuteLabelText: '분',
      errorInvalidText: '시간을 확인해주세요',
      initialEntryMode: TimePickerEntryMode.inputOnly,
      context: context,
      initialTime:
          isStartTime ? widget.selectedStartTime : widget.selectedEndTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            timePickerTheme: TimePickerThemeData(
              elevation: 0,
              backgroundColor: Pallete.whiteColor,
              dayPeriodTextColor: Pallete.greyColor,
              hourMinuteColor: Pallete.greyColor.withOpacity(0.1),
              hourMinuteTextColor: Pallete.greyColor,
              entryModeIconColor: Pallete.greyColor,
              helpTextStyle: AppTextStyles.headlineTextStyle,
              cancelButtonStyle: ButtonStyles.seconderyButton.copyWith(
                textStyle: MaterialStatePropertyAll<TextStyle>(
                  AppTextStyles.bodyTextStyle.copyWith(
                    color: Pallete.greyColor,
                  ),
                ),
                minimumSize: MaterialStatePropertyAll<Size>(
                  Size(MediaQuery.of(context).size.width / 3, 50),
                ),
              ),
              confirmButtonStyle: ButtonStyles.primaryButton.copyWith(
                textStyle: MaterialStatePropertyAll<TextStyle>(
                  AppTextStyles.bodyTextStyle.copyWith(
                    color: Pallete.greyColor,
                  ),
                ),
                minimumSize: MaterialStatePropertyAll<Size>(
                  Size(MediaQuery.of(context).size.width / 3, 50),
                ),
              ),
            ),
          ),
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
          widget.setStartTime(picked);
          widget.setEndTime(utils().addHours(picked, 2));
        } else {
          widget.setEndTime(picked);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
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
                  '${widget.selectedStartTime.format(context)}',
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
                  '${widget.selectedEndTime.format(context)}',
                  style: AppTextStyles.headlineTextStyle
                      .copyWith(color: Pallete.primaryColor),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
