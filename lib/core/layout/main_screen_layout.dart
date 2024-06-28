import 'package:derbymatch/core/values/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../theme/pallete.dart';

//데코레이터 같은 기능
class MainScreenLayout extends StatelessWidget {
  final Widget child;
  final String title;

  const MainScreenLayout({
    required this.child,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpaceSize.defaultSize),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Pallete.whiteColor,
          surfaceTintColor: Pallete.whiteColor,
          elevation: 0,
          leading: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              title!,
              style: AppTextStyles.titleTextStyle,
            ),
          ),
          leadingWidth: MediaQuery.of(context).size.width / 3,

          // !는 null이 안들어온다는 명시
        ),
        body: SafeArea(
          top: true,
          bottom: false,
          child: child,
        ),
      ),
    );
  }
}
