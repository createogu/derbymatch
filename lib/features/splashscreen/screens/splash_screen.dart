import 'package:derbymatch/core/theme/pallete.dart';
import 'package:derbymatch/core/values/values.dart';
import 'package:flutter/material.dart';

import '../../../core/layout/background/radialBackground.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        RadialBackground(
          color: Pallete.primaryColor,
          position: '',
        ),
        Center(
          child: Text(
            '더비매치',
            style: AppTextStyles.logoTextStyle,
          ),
        )
      ]),
    );
  }
}
