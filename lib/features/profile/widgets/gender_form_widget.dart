import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/controllers/CommCodeController.dart';
import '../../../core/theme/pallete.dart';
import '../../../core/values/values.dart';
import '../../auth/controllers/user_me_controller.dart';
import '../../auth/models/user_model.dart';

class GenderFormWidget extends ConsumerStatefulWidget {
  final goNextPage;
  final goPrevPage;

  const GenderFormWidget({
    required this.goNextPage,
    required this.goPrevPage,
    super.key,
  });

  @override
  ConsumerState<GenderFormWidget> createState() => _GenderFormWidgetState();
}

class _GenderFormWidgetState extends ConsumerState<GenderFormWidget>
    with SingleTickerProviderStateMixin {
  late String selectedGender;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    final userModel = ref.read(userMeProvider) as UserModel;
    selectedGender = userModel.gender;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = Tween<double>(begin: -0.1, end: 0.1).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onCardTap(String genderCode) {
    setState(() {
      selectedGender = genderCode;
    });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final userModel = ref.read(userMeProvider) as UserModel;
    final CommCodeController = ref.read(commCodeControllerProvider.notifier);
    List genderList = CommCodeController.getCommCodesByType('gender');
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text('${userModel.name}님 반갑습니다.\n성별은 무엇인가요?',
                textAlign: TextAlign.left,
                style: AppTextStyles.headlineTextStyle),
          ),
          Expanded(
            flex: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final gender in genderList)
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () => _onCardTap(gender['comm_cd']),
                      child: AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: selectedGender == gender['comm_cd']
                                ? _animation.value
                                : 0,
                            child: Card(
                              elevation: 0,
                              color: Colors.white,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child:
                                            Image.asset(gender['image_path']),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          gender['comm_cd_nm'],
                                          textAlign: TextAlign.center,
                                          style: AppTextStyles.bodyTextStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (selectedGender == gender['comm_cd'])
                                    Positioned(
                                      top: 10,
                                      right: 10,
                                      child: Icon(Icons.check_circle,
                                          color: Colors.green, size: 30),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Spacer(flex: 1),
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
                            userModel: userModel.copyWith(
                              gender: selectedGender,
                            ),
                          );
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
    );
  }
}
