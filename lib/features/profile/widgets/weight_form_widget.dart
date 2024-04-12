import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/pallete.dart';
import '../../../core/values/values.dart';
import '../../auth/controllers/user_me_controller.dart';
import '../../auth/models/user_model.dart';

class WeightFormWidget extends ConsumerStatefulWidget {
  final goNextPage;
  final goPrevPage;

  const WeightFormWidget({
    required this.goNextPage,
    required this.goPrevPage,
    super.key,
  });

  @override
  ConsumerState<WeightFormWidget> createState() => _WeightFormWidgetState();
}

class _WeightFormWidgetState extends ConsumerState<WeightFormWidget> {
  FocusNode textFocus = FocusNode();
  late final TextEditingController weightEditController;
  double weight = 70.0; // 초기 키 값 설정

  @override
  void initState() {
    super.initState();
    final userModel = ref.read(userMeProvider) as UserModel;
    weight =
        userModel.weight.toDouble() == 0 ? weight : userModel.weight.toDouble();
    weightEditController = TextEditingController(text: '${weight} kg');
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
                        '슬라이드를 조정해 체중을 선택해주세요.',
                        style: AppTextStyles.bodyTextStyle,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Slider(
                        min: 50,
                        max: 150,
                        divisions: 200,
                        activeColor: Pallete.primaryColor,
                        value: weight,
                        label: '${weight} kg',
                        onChanged: (double newValue) {
                          setModalState(() {
                            weight = newValue;
                            weightEditController.text = '${newValue} kg';
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
    weightEditController.dispose();
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
              child: Text('${userModel.name}님 체중은 몇 kg인가요?',
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
                    controller: weightEditController,
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
                              userModel: userModel.copyWith(weight: weight),
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
