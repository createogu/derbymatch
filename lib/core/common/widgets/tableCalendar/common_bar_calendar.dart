import 'package:derbymatch/core/theme/pallete.dart';
import 'package:derbymatch/core/values/values.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CommonBarCalendar extends StatefulWidget {
  final DateTime focusedDay;
  final Function onDaySelected; // 날짜 선택 콜백 추가

  const CommonBarCalendar({
    required this.focusedDay,
    required this.onDaySelected, // 생성자에 콜백 추가
    super.key,
  });

  @override
  State<CommonBarCalendar> createState() => _CommonBarCalendarState();
}

class _CommonBarCalendarState extends State<CommonBarCalendar> {
  DateTime firstDay = DateTime.utc(2024, 01, 01);
  DateTime lastDay = DateTime.utc(2030, 12, 31);

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarFormat: CalendarFormat.week,
      focusedDay: widget.focusedDay,
      firstDay: firstDay,
      lastDay: lastDay,
      availableCalendarFormats: {
        CalendarFormat.week: 'Week', // 월간 보기만 사용
      },
      headerStyle: HeaderStyle(
          titleCentered: true, titleTextStyle: AppTextStyles.headlineTextStyle),
      calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            // 오늘 날짜 스타일 정의
            border: Border.all(color: Pallete.seconderyColor),
            shape: BoxShape.circle, // 원형 표시
          ),
          todayTextStyle: AppTextStyles.bodyTextStyle,
          selectedDecoration: BoxDecoration(
            // 오늘 날짜 스타일 정의
            color: Pallete.primaryColor,
            shape: BoxShape.circle, // 원형 표시
          ),
          selectedTextStyle: AppTextStyles.bodyTextStyle.copyWith(
              color: Pallete.whiteColor, fontWeight: FontWeight.w700)),

      selectedDayPredicate: (day) => isSameDay(widget.focusedDay, day),
      // 선택된 날짜를 시각적으로 표시
      onDaySelected: (selectedDay, focusedDay) {
        widget.onDaySelected(selectedDay); // 선택된 날짜를 콜백으로 전달
      },
    );
  }
}
