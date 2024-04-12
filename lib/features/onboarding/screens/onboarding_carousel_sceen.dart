import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:routemaster/routemaster.dart';

import '../../../core/layout/background/radialBackground.dart';
import '../../../core/values/values.dart';
import '../widgets/image_outlined_button.dart';
import '../widgets/slider_captioned_image.dart';

class OnboardingCarouselScreen extends StatefulWidget {
  @override
  _OnboardingCarouselScreenState createState() =>
      _OnboardingCarouselScreenState();
}

class _OnboardingCarouselScreenState extends State<OnboardingCarouselScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: 8.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            isActive ? HexColor.fromHex("266FFE") : HexColor.fromHex("666A7A"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Stack(children: [
              Container(
                // height: double.infinity,
                // width: double.infinity,
                child: RadialBackground(
                  color: HexColor.fromHex("#181a1f"),
                  position: "bottomRight",
                ),
              ),
              //Buttons positioned below
              Column(children: [
                Container(
                    height: MediaQuery.of(context).size.height - 300,
                    width: MediaQuery.of(context).size.width,
                    child: PageView(
                        physics: ClampingScrollPhysics(),
                        controller: _pageController,
                        onPageChanged: (int page) {
                          setState(() {
                            _currentPage = page;
                          });
                        },
                        children: <Widget>[
                          SliderCaptionedImage(
                              index: 0,
                              imageUrl:
                                  "asset/img/onboarding/onboarding_1.png",
                              caption: "Task,\nCalendar,\nChat"),
                          SliderCaptionedImage(
                              index: 1,
                              imageUrl:
                                  "asset/img/onboarding/onboarding_background_2.jpg",
                              caption: "Work\nAnywhere\nEasily"),
                          SliderCaptionedImage(
                              index: 2,
                              imageUrl:
                                  "asset/img/onboarding/onboarding_background_3.jpg",
                              caption: "Manage\nEverything\nOn Phone")
                        ])),
                Padding(
                  padding:
                      EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: _buildPageIndicator(),
                        ),
                        SizedBox(height: 50),
                        Container(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                              onPressed: () {
                                Routemaster.of(context).push('/main');
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      HexColor.fromHex("246CFE")),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          side: BorderSide(
                                              color: HexColor.fromHex(
                                                  "246CFE"))))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.email, color: Colors.white),
                                  Text('   Continue with Email',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white)),
                                ],
                              )),
                        ),
                        SizedBox(height: 10.0),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: OutlinedButtonWithImage(
                                      imageUrl: "assets/google_icon.png")),
                              SizedBox(width: 20),
                              Expanded(
                                  child: OutlinedButtonWithImage(
                                      imageUrl: "assets/facebook_icon.png"))
                            ]),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                              'By continuing you agree Taskez\'s Terms of Services & Privacy Policy.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: HexColor.fromHex("666A7A"))),
                        )
                      ]),
                    ),
                  ),
                ),
              ])
            ])));
  }
}
