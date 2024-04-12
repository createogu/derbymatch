import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/pallete.dart';
import '../../../../core/values/values.dart';
import '../widgets/form/team_address_form_widget.dart';
import '../widgets/form/team_division_form_widget.dart';
import '../widgets/form/team_logo_image_form_widget.dart';
import '../widgets/form/team_name_form_widget.dart';
import '../widgets/form/team_since_year_form_widget.dart';

class CreateTeamScreen extends ConsumerStatefulWidget {
  const CreateTeamScreen({super.key});

  @override
  ConsumerState<CreateTeamScreen> createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends ConsumerState<CreateTeamScreen> {
  int currentPage = 0;
  late final PageController _pageController;
  late final List<Widget> teamCreateStep;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    teamCreateStep = [
      TeamNameFormWidget(goNextPage: goNextPage, goPrevPage: goPrevPage),
      TeamLogoImageFormWidget(goNextPage: goNextPage, goPrevPage: goPrevPage),
      TeamSinceYearFormWidget(goNextPage: goNextPage, goPrevPage: goPrevPage),
      // TeamGenderFormWidget(goNextPage: goNextPage, goPrevPage: goPrevPage),
      TeamDivisionFormWidget(goNextPage: goNextPage, goPrevPage: goPrevPage),
      TeamAddressFormWidget(goNextPage: goNextPage, goPrevPage: goPrevPage),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void goNextPage() {
    if (_pageController.hasClients &&
        _pageController.page! < teamCreateStep.length) {
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
              '팀 생성중',
              style: AppTextStyles.bodyTextStyle,
            ),
            content: Text(
              '팀 생성중 입니다. 화면을 나가시겠습니까?',
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
            '팀 생성',
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
                    teamCreateStep.length,
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
                    itemCount: teamCreateStep.length,
                    itemBuilder: (context, index) => teamCreateStep[index],
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
