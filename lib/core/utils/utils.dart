part of values;

class utils {
  TimeOfDay addHours(TimeOfDay time, int hours) {
    int newHour = time.hour + hours;
    if (newHour >= 24) {
      newHour -= 24; // 24시를 넘어가면 0시부터 다시 시작
    }
    return TimeOfDay(hour: newHour, minute: time.minute);
  }

  String formatTimeOfDay(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
