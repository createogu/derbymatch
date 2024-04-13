part of values;

class utils {
  TimeOfDay addHours(TimeOfDay time, int hours) {
    int newHour = time.hour + hours;
    if (newHour >= 24) {
      newHour -= 24; // 24시를 넘어가면 0시부터 다시 시작
    }
    return TimeOfDay(hour: newHour, minute: time.minute);
  }

// 문자열을 DateTime으로 변환
  DateTime stringToDate(String dateTimeString) {
    try {
      // 날짜와 시간이 포함된 문자열에서 날짜 부분만 추출
      String dateString =
          dateTimeString.split(' ')[0]; // 공백을 기준으로 분리하여 날짜 부분만 사용
      return DateFormat("yyyy-MM-dd").parseStrict(dateString);
    } catch (e) {
      throw FormatException("Invalid date format or value: $dateTimeString");
    }
  }

// DateTime을 문자열로 변환
  String dateTimeToString(DateTime dateTime) {
    return DateFormat("yyyy-MM-dd HH:mm:ss").format(dateTime);
  }

  String timeOfDayToString(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  TimeOfDay stringToTimeOfDay(String time) {
    final String hour = time.substring(0, 2);
    final String minute = time.substring(3, 5);
    print(TimeOfDay(hour: int.parse(hour), minute: int.parse(minute)));
    return TimeOfDay(hour: int.parse(hour), minute: int.parse(minute));
  }
}
