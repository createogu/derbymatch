import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import '../theme/pallete.dart';
import '../constants/constants.dart';
import '../values/values.dart';

class ViewScreenLayout extends StatelessWidget {
  final Widget child;
  final Widget? bottomSheet;
  final String title;
  final VoidCallback onRegister;
  final bool canRegister;

  ViewScreenLayout({
    required this.child,
    required this.title,
    required this.onRegister,
    required this.canRegister,
    this.bottomSheet,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.whiteColor,
        surfaceTintColor: Pallete.whiteColor,
        elevation: 0,
        leading: Container(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () {
              Routemaster.of(context).pop();
            },
            child: Text(
              '이전',
              style: AppTextStyles.infoTextStyle.copyWith(
                color: Pallete.greyColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        leadingWidth: MediaQuery.of(context).size.width / 3,
        title: Text(
          title,
          style: AppTextStyles.bodyTextStyle,
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (canRegister) {
                onRegister();
              }
            },
            child: Text(
              '수정',
              style: AppTextStyles.infoTextStyle.copyWith(
                color: canRegister
                    ? Pallete.primaryColor
                    : Pallete.greyColor.withOpacity(0.5),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: true,
        bottom: true,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpaceSize.defaultSize),
          child: child,
        ),
      ),
      // GestureDetector를 유지하여 사용자가 탭하면 BottomSheet를 보여줌
      bottomSheet: bottomSheet ?? null,
    );
  }
}
