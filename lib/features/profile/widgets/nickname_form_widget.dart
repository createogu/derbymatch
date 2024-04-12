import 'package:derbymatch/core/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/widgets/label_with_form_field.dart';
import '../../../core/values/values.dart';
import '../../auth/controllers/user_me_controller.dart';
import '../../auth/models/user_model.dart';

class NicknameFormWidget extends ConsumerStatefulWidget {
  final goNextPage;
  final goPrevPage;

  const NicknameFormWidget({
    required this.goNextPage,
    required this.goPrevPage,
    super.key,
  });

  @override
  ConsumerState<NicknameFormWidget> createState() => _NicknameFormWidgetState();
}

class _NicknameFormWidgetState extends ConsumerState<NicknameFormWidget> {
  FocusNode textFocus = FocusNode();
  late final TextEditingController nicknameEditController;

  @override
  void initState() {
    super.initState();
    final userModel = ref.read(userMeProvider) as UserModel;
    nicknameEditController = new TextEditingController(text: userModel.name);
  }

  @override
  void dispose() {
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
          children: [
            Expanded(
              flex: 4,
              child: LabelWithFormField(
                controller: nicknameEditController,
                label: '당신의 이름을 알려주세요',
                keyboardType: 'text',
                placeholder: '불쾌감을 주는 닉네임은 지양해주세요.',
                obscureText: false,
                textFocus: textFocus,
              ),
            ),
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // 버튼들 사이에 공간을 균등하게 배분
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () async {
                        textFocus.unfocus();
                        await ref.read(userMeProvider.notifier).editUserModel(
                              isSave: false,
                              userModel: userModel.copyWith(
                                  name: nicknameEditController.text),
                            );
                        // 다음 페이지로 이동
                        widget.goNextPage();
                      },
                      child: Text(
                        // profileStep.length == currentPage + 1 ? "완료" :
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
