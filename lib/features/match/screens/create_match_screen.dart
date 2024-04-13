import 'package:derbymatch/features/match/widgets/form/match_date_tiem_form_widget.dart';
import 'package:derbymatch/features/match/widgets/form/match_type_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/pallete.dart';
import '../../../../core/values/values.dart';

class CreateMatchScreen extends ConsumerStatefulWidget {
  const CreateMatchScreen({super.key});

  @override
  ConsumerState<CreateMatchScreen> createState() => _CreateMatchScreenState();
}

class _CreateMatchScreenState extends ConsumerState<CreateMatchScreen> {
  int currentPage = 0;
  late final PageController _pageController;
  late final List<Widget> matchCreateStep;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    matchCreateStep = [
      MatchTypeFormWidget(goNextPage: goNextPage, goPrevPage: goPrevPage),
      MatchDateTimeFormWidget(goNextPage: goNextPage, goPrevPage: goPrevPage),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void goNextPage() {
    if (_pageController.hasClients &&
        _pageController.page! < matchCreateStep.length) {
      _pageController.animateToPage(
        (_pageController.page?.toInt() ?? 0) + 1,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void goPrevPage() {
    if (_pageController.hasClients && _pageController.page! > 0) {
      _pageController.animateToPage(
        (_pageController.page?.toInt() ?? 0) - 1,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<bool> _onWillPop() async {
    return (await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Pallete.whiteColor,
            elevation: 0,
            title: Text(
              '매치 생성중',
              style: AppTextStyles.bodyTextStyle,
            ),
            content: Text(
              '매치 생성중 입니다. 화면을 나가시겠습니까?',
              style: AppTextStyles.headlineTextStyle,
            ),
            actions: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text(
                        '아니요',
                        style: AppTextStyles.cautionTextStyle
                            .copyWith(color: Pallete.blackColor),
                      ),
                      style: ButtonStyles.seconderyButton.copyWith(
                        minimumSize: MaterialStatePropertyAll<Size>(
                          Size(double.infinity, 40),
                        ),
                      ),
                    ),
                  ),
                  AppSpacesBox.horizontalSpaceSmall,
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text(
                        '예',
                        style: AppTextStyles.cautionTextStyle
                            .copyWith(color: Pallete.whiteColor),
                      ),
                      style: ButtonStyles.primaryButton.copyWith(
                        minimumSize: MaterialStatePropertyAll<Size>(
                          Size(double.infinity, 40),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '매치 생성',
            style: AppTextStyles.titleTextStyle,
          ),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    matchCreateStep.length,
                    (index) => AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(right: 5),
                      height: 6,
                      width: currentPage == index ? 30 : 10,
                      decoration: BoxDecoration(
                        color: currentPage == index
                            ? Pallete.primaryColor
                            : const Color(0xFFD8D8D8),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppSpaceSize.largeSize),
                  child: PageView.builder(
                    controller: _pageController,
                    physics: NeverScrollableScrollPhysics(),
                    onPageChanged: (value) {
                      setState(() {
                        currentPage = value;
                      });
                    },
                    itemCount: matchCreateStep.length,
                    itemBuilder: (context, index) => matchCreateStep[index],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
