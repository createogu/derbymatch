import 'package:derbymatch/core/values/values.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';

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
      body: Padding(
        padding: EdgeInsets.all(AppSpaceSize.defaultSize),
        child: Column(
          children: <Widget>[
            Spacer(
              flex: 2,
            ),
            Expanded(
              flex: 3,
              child: Image.asset(Constants.logoPath),
            ),
            Expanded(
              flex: 1,
              child: Text(
                "Prove You're the Best in Your Region",
                style: AppTextStyles.bodyTextStyle,
              ),
            ),
            Spacer(
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}
