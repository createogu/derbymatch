import 'package:derbymatch/core/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

import '../../../../core/values/values.dart';
import '../../onboarding/widgets/splash_content.dart';

class CreateTeamOnboardingScreen extends StatefulWidget {
  const CreateTeamOnboardingScreen({super.key});

  @override
  State<CreateTeamOnboardingScreen> createState() =>
      _CreateTeamOnboardingScreenState();
}

class _CreateTeamOnboardingScreenState
    extends State<CreateTeamOnboardingScreen> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "우리 지역 최고의 농구팀이 되어보세요",
      "subText": "더비매치'와 함께 경기 하고, 지역 내에서 명성을 쌓으며 팀의 역사를 써 내려가세요",
      "image": "asset/img/onboarding/onboarding_1.png"
    },
    {
      "text": "흥미진진한 농구 경기, 직접 조직해보세요!",
      "subText": "교류전과 자체전을 개설하고, 게스트를 모집해 다채로운 경기를 경험하세요.",
      "image": "asset/img/onboarding/onboarding_background_2.jpg"
    },
    {
      "text": "실시간 경기 기록과 통계!",
      "subText": "자체 제작한 스코어보드를 통해 모든 경기 내용을 기록하고 분석해보세요.",
      "image": "asset/img/onboarding/onboarding_background_3.jpg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                  subText: splashData[index]['subText'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
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
                    const Spacer(flex: 1),
                    ElevatedButton(
                      onPressed: currentPage == 2
                          ? () {
                              Routemaster.of(context).push('/createTeam');
                            }
                          : null,
                      child: Text(
                        "시작하기",
                        style: AppTextStyles.bodyTextStyle
                            .copyWith(color: Pallete.whiteColor),
                      ),
                      style: ButtonStyles.primaryButton,
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
