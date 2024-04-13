import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CommonTableCalendar extends StatefulWidget {
  final DateTime focusedDay;
  final Function onDaySelected; // 날짜 선택 콜백 추가

  const CommonTableCalendar({
    required this.focusedDay,
    required this.onDaySelected, // 생성자에 콜백 추가
    super.key,
  });

  @override
  State<CommonTableCalendar> createState() => _CommonTableCalendarState();
}

class _CommonTableCalendarState extends State<CommonTableCalendar> {
  DateTime firstDay = DateTime.utc(2024, 01, 01);
  DateTime lastDay = DateTime.utc(2030, 12, 31);

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: widget.focusedDay,
      firstDay: firstDay,
      lastDay: lastDay,
      selectedDayPredicate: (day) => isSameDay(widget.focusedDay, day),
      // 선택된 날짜를 시각적으로 표시
      onDaySelected: (selectedDay, focusedDay) {
        widget.onDaySelected(selectedDay); // 선택된 날짜를 콜백으로 전달
      },
    );
  }
}
