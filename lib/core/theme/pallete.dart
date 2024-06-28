import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});

class Pallete {
  // Colors
  static const primaryColor = Color(0xFFF79902);
  static const seconderyColor = Color(0xFFF7B702);
  static const backgroundColor = Color.fromRGBO(233, 236, 239, 1.0);

  static const blackColor = Color.fromRGBO(1, 1, 1, 1); // primary color
  static const greyColor = Color.fromRGBO(92, 93, 98, 1.0); // secondary color
  static const drawerColor = primaryColor;
  static const whiteColor = Colors.white;
  static var redColor = Colors.red.shade500;
  static var blueColor = Colors.blue.shade300;

  // Themes
  static var darkModeAppTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: blackColor,
    cardColor: greyColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: drawerColor,
      iconTheme: IconThemeData(
        color: whiteColor,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: primaryColor,
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: whiteColor,
      dialHandColor: primaryColor,
      // 시간 선택기의 핸드 색상을 주황색으로 설정
      dialTextColor: greyColor,
      // 다이얼 텍스트 색상을 검정색으로 설정
      hourMinuteTextColor: greyColor,
      // 시간과 분의 텍스트 색상을 검정색으로 설정
      dayPeriodTextColor: greyColor,
      // AM/PM 텍스트 색상을 검정색으로 설정
      entryModeIconColor: greyColor,
      // 입력 모드 아이콘 색상을 검정색으로 설정
      helpTextStyle: TextStyle(color: Colors.black), // 도움말 텍스트 스타일을 검정색으로 설정
    ),
    primaryColor: redColor,
    backgroundColor:
        primaryColor, // will be used as alternative background color
  );

  static var lightModeAppTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: whiteColor,
    cardColor: greyColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: whiteColor,
      elevation: 0,
      iconTheme: IconThemeData(
        color: blackColor,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: primaryColor,
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: whiteColor,
      dialHandColor: primaryColor,
      // 시간 선택기의 핸드 색상을 주황색으로 설정
      dialTextColor: greyColor,
      // 다이얼 텍스트 색상을 검정색으로 설정
      hourMinuteTextColor: greyColor,
      // 시간과 분의 텍스트 색상을 검정색으로 설정
      dayPeriodTextColor: greyColor,
      // AM/PM 텍스트 색상을 검정색으로 설정
      entryModeIconColor: greyColor,
      // 입력 모드 아이콘 색상을 검정색으로 설정
      helpTextStyle: TextStyle(color: Colors.black), // 도움말 텍스트 스타일을 검정색으로 설정
    ),
    primaryColor: primaryColor,
    backgroundColor: primaryColor,
  );
}

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeMode _mode;

  ThemeNotifier({ThemeMode mode = ThemeMode.light})
      : _mode = mode,
        super(
          Pallete.lightModeAppTheme,
        ) {
    getTheme();
  }

  ThemeMode get mode => _mode;

  void getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final theme = prefs.getString('dark');
    if (theme == 'dark') {
      _mode = ThemeMode.dark;
      state = Pallete.darkModeAppTheme;
    } else {
      _mode = ThemeMode.light;
      state = Pallete.lightModeAppTheme;
    }
  }

  void toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (_mode == ThemeMode.dark) {
      _mode = ThemeMode.light;
      state = Pallete.lightModeAppTheme;
      prefs.setString('theme', 'light');
    } else {
      _mode = ThemeMode.dark;
      state = Pallete.darkModeAppTheme;
      prefs.setString('theme', 'dark');
    }
  }
}
