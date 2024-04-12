import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/pallete.dart';
import '../../../core/values/values.dart';
import '../../auth/controllers/user_me_controller.dart';
import '../../auth/models/user_model.dart';

class HeightFormWidget extends ConsumerStatefulWidget {
  final goNextPage;
  final goPrevPage;

  const HeightFormWidget({
    required this.goNextPage,
    required this.goPrevPage,
    super.key,
  });

  @override
  ConsumerState<HeightFormWidget> createState() => _HeightFormWidgetState();
}

class _HeightFormWidgetState extends ConsumerState<HeightFormWidget> {
  FocusNode textFocus = FocusNode();
  late final TextEditingController heightEditController;
  double height = 170.0; // 초기 키 값 설정

  @override
  void initState() {
    super.initState();
    final userModel = ref.read(userMeProvider) as UserModel;
    height =
        userModel.height.toDouble() == 0 ? height : userModel.height.toDouble();
    heightEditController = TextEditingController(text: '${height} cm');
  }

  void _showHeightPicker() {
    showModalBottomSheet(
      backgroundColor: Pallete.whiteColor,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppSpaceSize.mediumSize),
              child: Container(
                height: 300,
                child: Column(
                  children: [
                    Spacer(
                      flex: 1,
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        '슬라이드를 조정해 키를 선택해주세요.',
                        style: AppTextStyles.bodyTextStyle,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Slider(
                        min: 150,
                        max: 220,
                        divisions: 140,
                        activeColor: Pallete.primaryColor,
                        value: height,
                        label: '${height} cm',
                        onChanged: (double newValue) {
                          setModalState(() {
                            height = newValue;
                            heightEditController.text = '${newValue} cm';
                          });
                        },
                      ),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        child: Text(
                          '확인',
                          style: AppTextStyles.bodyTextStyle.copyWith(
                            color: Pallete.whiteColor,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ButtonStyles.primaryButton,
                      ),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    textFocus.dispose();
    heightEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userModel = ref.read(userMeProvider) as UserModel;

    return GestureDetector(
      onTap: () {
        textFocus.unfocus();
      },
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Text('${userModel.name}님 키는 몇 cm인가요?',
                  textAlign: TextAlign.left,
                  style: AppTextStyles.headlineTextStyle),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: _showHeightPicker,
                child: AbsorbPointer(
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: heightEditController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: 'cm',
                    ),
                    focusNode: textFocus,
                    style: AppTextStyles.headerTextStyle,
                  ),
                ),
              ),
            ),
            Spacer(
              flex: 3,
            ),
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () {
                        widget.goPrevPage();
                      },
                      child: Text("이전",
                          style: AppTextStyles.bodyTextStyle
                              .copyWith(color: Pallete.primaryColor)),
                      style: ButtonStyles.seconderyButton,
                    ),
                  ),
                  AppSpacesBox.horizontalSpaceSmall,
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () async {
                        await ref.read(userMeProvider.notifier).editUserModel(
                          isSave: false,
                              userModel: userModel.copyWith(height: height),
                            );
                        widget.goNextPage();
                      },
                      child: Text(
                        "다음",
                        style: AppTextStyles.bodyTextStyle
                            .copyWith(color: Pallete.whiteColor),
                      ),
                      style: ButtonStyles.primaryButton,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: AppSpaceSize.xlargeSize,
            ),
          ],
        ),
      ),
    );
  }
}
