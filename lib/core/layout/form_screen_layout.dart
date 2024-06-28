import 'package:derbymatch/core/values/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

import '../constants/constants.dart';
import '../theme/pallete.dart';

class FormScreenLayout extends StatelessWidget {
  final Widget child;
  final String title;
  final String content;
  final VoidCallback onRegister; // 외부에서 전달받을 함수
  final bool canRegister;

  const FormScreenLayout({
    required this.child,
    required this.title,
    required this.content,
    required this.onRegister,
    required this.canRegister,
    Key? key,
  }) : super(key: key);

  Future<bool> _showExitDialog(BuildContext context) async {
    return (await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            icon: Icon(Icons.warning_amber_outlined,
                color: Pallete.primaryColor, size: 30),
            backgroundColor: Pallete.whiteColor,
            elevation: 0,
            // title: Text(title, style: AppTextStyles.infoTextStyle),
            content: Text(content, style: AppTextStyles.bodyTextStyle),
            actions: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Routemaster.of(context).pop(false),
                      child: Text('유지',
                          style: AppTextStyles.infoTextStyle
                              .copyWith(color: Pallete.blackColor)),
                      style: ButtonStyles.seconderyButton.copyWith(
                        minimumSize: MaterialStatePropertyAll<Size>(
                            Size(double.infinity, 40)),
                      ),
                    ),
                  ),
                  AppSpacesBox.horizontalSpaceSmall,
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Routemaster.of(context).pop(true),
                      child: Text('삭제',
                          style: AppTextStyles.infoTextStyle
                              .copyWith(color: Pallete.whiteColor)),
                      style: ButtonStyles.primaryButton.copyWith(
                        minimumSize: MaterialStatePropertyAll<Size>(
                            Size(double.infinity, 40)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )) ??
        false; // Default action if dialog is dismissed
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _showExitDialog(context), // 이 부분이 수정된 부분입니다.
      child: Scaffold(
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
                '취소',
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
                  print(222);
                }
              },
              child: Text(
                '등록',
                style: AppTextStyles.infoTextStyle.copyWith(
                    color: canRegister
                        ? Pallete.primaryColor
                        : Pallete.greyColor.withOpacity(0.5),
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
        body: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpaceSize.defaultSize),
            child: child,
          ),
        ),
      ),
    );
  }
}
