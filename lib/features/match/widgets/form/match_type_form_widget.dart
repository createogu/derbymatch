import 'package:derbymatch/features/match/controllers/match_create_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/pallete.dart';
import '../../../../../core/values/values.dart';
import '../../../../core/common/controllers/CommCodeController.dart';

class MatchTypeFormWidget extends ConsumerStatefulWidget {
  final goNextPage;
  final goPrevPage;

  const MatchTypeFormWidget({
    required this.goNextPage,
    required this.goPrevPage,
    super.key,
  });

  @override
  ConsumerState<MatchTypeFormWidget> createState() =>
      _MatchTypeFormWidgetState();
}

class _MatchTypeFormWidgetState extends ConsumerState<MatchTypeFormWidget>
    with SingleTickerProviderStateMixin {
  late String selectedMatchType;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    final matchCommand = ref.read(matchCreateProvider);
    selectedMatchType = matchCommand.match_type;
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
      selectedMatchType = divisioinCode;
    });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final matchCommand = ref.read(matchCreateProvider);
    final CommCodeController = ref.read(commCodeControllerProvider.notifier);
    List matchTypeList = CommCodeController.getCommCodesByType('matchType');
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text('매치 유형을 선택해주세요',
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
              itemCount: matchTypeList.length,
              itemBuilder: (context, index) {
                var matchType = matchTypeList[index];
                return GestureDetector(
                  onTap: () => _onCardTap(matchType.comm_cd),
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: selectedMatchType.contains(matchType.comm_cd)
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
                                    child: Image.asset(matchType.image_path),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      matchType.comm_cd_nm,
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.bodyTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                              if (selectedMatchType.contains(matchType.comm_cd))
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
                      await ref
                          .read(matchCreateProvider.notifier)
                          .editMatchModel(
                            isSave: false,
                            matchCommand: matchCommand.copyWith(
                                match_type: selectedMatchType),
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
