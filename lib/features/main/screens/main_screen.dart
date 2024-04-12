import 'package:derbymatch/core/theme/pallete.dart';
import 'package:derbymatch/features/community/screens/community_main_screen.dart';
import 'package:derbymatch/features/home/screens/home_main_screen.dart';
import 'package:derbymatch/features/setting/screens/setting_main_screen.dart';
import 'package:flutter/material.dart';

import '../../../core/layout/default_layout.dart';
import '../../court/screens/court_main_screen.dart';
import '../../player/screens/player_main_screen.dart';
import '../../team/screens/team_main_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

//tabController을 사용하기 위해선 SingleTickerProviderStateMixin 추가해 줘야 함.
class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  // late 변수 선언 이후 값이 할당 될 거란 약속
  late TabController controller;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 5, vsync: this);

    //addListener 뭔지 다시 확인하자
    // 컨트롤러의 상태가 변경 될 때마다 이벤트 발생
    controller.addListener(tabListener);
  }

  //dispose 뭔지 찾아보자
  // 위젯이 메모리에서 제거 될 때 실행되는 함수
  @override
  void dispose() {
    controller.removeListener(tabListener);
    super.dispose();
  }

  void tabListener() {
    setState(() {
      currentIndex = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroudColor: Pallete.whiteColor,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Pallete.whiteColor,
        selectedItemColor: Pallete.primaryColor,
        unselectedItemColor: Pallete.greyColor,
        selectedFontSize: 14.0,
        unselectedFontSize: 14.0,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          // 상태값은 setState에서 변경해야 한다.
          controller.animateTo(index);
        },
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '팀',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: '매치',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: '커뮤니티',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility),
            label: 'MY',
          ),
        ],
      ),
      child: TabBarView(
        controller: controller,
        //좌우 스와이프 제한
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomeMainScreen(),
          DefaultLayout(
            child: TeamMainScreen(),
          ),
          DefaultLayout(
            child: CourtMainScreen(),
          ),
          DefaultLayout(
            title: '커뮤니티',
            child: PlayerMainScreen(),
          ),
          DefaultLayout(
            child: SettingMainScreen(),
          ),
        ],
      ),
    );
  }
}
