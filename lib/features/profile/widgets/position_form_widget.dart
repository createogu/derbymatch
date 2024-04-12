import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/controllers/CommCodeController.dart';
import '../../../core/theme/pallete.dart';
import '../../../core/values/values.dart';
import '../../auth/controllers/user_me_controller.dart';
import '../../auth/models/user_model.dart';

class PositionFormWidget extends ConsumerStatefulWidget {
  final goNextPage;
  final goPrevPage;

  const PositionFormWidget({
    required this.goNextPage,
    required this.goPrevPage,
    super.key,
  });

  @override
  ConsumerState<PositionFormWidget> createState() => _DivisionFormWidgetState();
}

class _DivisionFormWidgetState extends ConsumerState<PositionFormWidget>
    with SingleTickerProviderStateMixin {
  late List<String> selectedPositions;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    final userModel = ref.read(userMeProvider) as UserModel;
    selectedPositions = userModel.positions;
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

  void _onCardTap(String positionCode) {
    setState(() {
      if (selectedPositions.contains(positionCode)) {
        selectedPositions.remove(positionCode);
      } else {
        selectedPositions.add(positionCode);
      }
    });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final userModel = ref.read(userMeProvider) as UserModel;
    final CommCodeController = ref.read(commCodeControllerProvider.notifier);
    List positionList = CommCodeController.getCommCodesByType('position');

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text('${userModel.name}님, 포지션이 무엇인가요?\n중복 선택이 가능합니다.',
                textAlign: TextAlign.left,
                style: AppTextStyles.headlineTextStyle),
          ),
          Flexible(
            flex: 4,
            child: GridView.builder(
              physics: ScrollPhysics(), // 스크롤 가능
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
              ),
              itemCount: positionList.length,
              itemBuilder: (context, index) {
                var position = positionList[index];
                return GestureDetector(
                  onTap: () => _onCardTap(position['comm_cd']),
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: selectedPositions.contains(position['comm_cd'])
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
                                    child: Image.asset(position['image_path']),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      position['comm_cd_nm'],
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.bodyTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                              if (selectedPositions
                                  .contains(position['comm_cd']))
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
                              positions: selectedPositions,
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
