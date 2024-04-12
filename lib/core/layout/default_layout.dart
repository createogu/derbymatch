import 'package:derbymatch/core/values/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../theme/pallete.dart';

//데코레이터 같은 기능
class DefaultLayout extends StatelessWidget {
  final Widget child;
  final Color? backgroudColor;
  final String? title;
  final Widget? bottomNavigationBar;

  const DefaultLayout({
    required this.child,
    this.backgroudColor,
    this.title,
    this.bottomNavigationBar,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RenderAppBar(),
      bottomNavigationBar: bottomNavigationBar,
      //??는 왼쪽 값이 null이면 오른쪽 값
      backgroundColor: backgroudColor ?? Pallete.whiteColor,
      body: SafeArea(
        top: true,
        bottom: false,
        child: child,
      ),
    );
  }

  AppBar? RenderAppBar() {
    if (title == null) {
    } else {
      return AppBar(
        backgroundColor: Pallete.whiteColor,
        surfaceTintColor: Pallete.whiteColor,
        elevation: 0,
        title: Container(
          alignment: Alignment.center,
          child: Text(
            title!,
            style: AppTextStyles.titleTextStyle,
          ),
        ),
        // !는 null이 안들어온다는 명시
        leading: Image.asset(
          Constants.logoPath,
          height: 50,
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              '설정',
              style: AppTextStyles.bodyTextStyle
                  .copyWith(color: Pallete.blackColor),
            ),
          ),
        ],
      );
    }
  }
}
