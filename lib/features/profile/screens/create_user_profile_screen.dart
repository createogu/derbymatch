import 'package:derbymatch/features/profile/widgets/address_form_widget.dart';
import 'package:derbymatch/features/profile/widgets/division_form_widget.dart';
import 'package:derbymatch/features/profile/widgets/height_form_widget.dart';
import 'package:derbymatch/features/profile/widgets/nickname_form_widget.dart';
import 'package:derbymatch/features/profile/widgets/position_form_widget.dart';
import 'package:derbymatch/features/profile/widgets/profile_image_form_widget.dart';
import 'package:derbymatch/features/profile/widgets/weight_form_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/pallete.dart';
import '../../../core/values/values.dart';
import '../widgets/gender_form_widget.dart';

class CreateUserProfileScreen extends ConsumerStatefulWidget {
  const CreateUserProfileScreen({super.key});

  @override
  ConsumerState<CreateUserProfileScreen> createState() =>
      _CreateUserProfileScreenState();
}

class _CreateUserProfileScreenState
    extends ConsumerState<CreateUserProfileScreen> {
  int currentPage = 0;
  late final PageController _pageController;
  late final List<Widget> profileStep;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    profileStep = [
      NicknameFormWidget(
        goNextPage: goNextPage,
        goPrevPage: goPrevPage,
      ),
      GenderFormWidget(
        goNextPage: goNextPage,
        goPrevPage: goPrevPage,
      ),
      ProfileImageFormWidget(
        goNextPage: goNextPage,
        goPrevPage: goPrevPage,
      ),
      DivisionFormWidget(
        goNextPage: goNextPage,
        goPrevPage: goPrevPage,
      ),
      PositionFormWidget(
        goNextPage: goNextPage,
        goPrevPage: goPrevPage,
      ),
      HeightFormWidget(
        goNextPage: goNextPage,
        goPrevPage: goPrevPage,
      ),
      WeightFormWidget(
        goNextPage: goNextPage,
        goPrevPage: goPrevPage,
      ),
      AddressFormWidget(
        goNextPage: goNextPage,
        goPrevPage: goPrevPage,
      ),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void goNextPage() {
    if (_pageController.hasClients &&
        _pageController.page! < profileStep.length) {
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
              '프로필 작성중',
              style: AppTextStyles.headerTextStyle,
            ),
            content: Text(
              '프로필 작성중 입니다. 화면을 나가시겠습니까?',
              style: AppTextStyles.bodyTextStyle,
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
                      style: ButtonStyles.seconderyButton,
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
                      style: ButtonStyles.primaryButton,
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
            '프로필등록',
            style: AppTextStyles.headlineTextStyle,
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
                    profileStep.length,
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
                    itemCount: profileStep.length,
                    itemBuilder: (context, index) => profileStep[index],
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
