import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/controllers/CommCodeController.dart';
import '../../../core/theme/pallete.dart';
import '../../../core/values/values.dart';
import '../../auth/controllers/user_me_controller.dart';
import '../../auth/models/user_model.dart';

class DivisionFormWidget extends ConsumerStatefulWidget {
  final goNextPage;
  final goPrevPage;

  const DivisionFormWidget({
    required this.goNextPage,
    required this.goPrevPage,
    super.key,
  });

  @override
  ConsumerState<DivisionFormWidget> createState() => _DivisionFormWidgetState();
}

class _DivisionFormWidgetState extends ConsumerState<DivisionFormWidget>
    with SingleTickerProviderStateMixin {
  late String selectedDivision;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    final userModel = ref.read(userMeProvider) as UserModel;
    selectedDivision = userModel.division;
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

  void _onCardTap(String divisioinCode) {
    setState(() {
      selectedDivision = divisioinCode;
    });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final userModel = ref.read(userMeProvider) as UserModel;
    final CommCodeController = ref.read(commCodeControllerProvider.notifier);
    List divisionList = CommCodeController.getCommCodesByType('division');
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text('${userModel.name}님 어떤 부에서 뛰고 계신가요?',
                textAlign: TextAlign.left,
                style: AppTextStyles.headlineTextStyle),
          ),
          Expanded(
            flex: 4,
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
              ),
              itemCount: divisionList.length,
              itemBuilder: (context, index) {
                var division = divisionList[index];
                return GestureDetector(
                  onTap: () => _onCardTap(division['comm_cd']),
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: selectedDivision == division['comm_cd']
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
                                    child: Image.asset(division['image_path']),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      division['comm_cd_nm'],
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.bodyTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                              if (selectedDivision == division['comm_cd'])
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
                );
              },
            ),
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
                            userModel: userModel.copyWith(
                              division: selectedDivision,
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