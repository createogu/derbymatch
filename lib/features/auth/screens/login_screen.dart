import 'package:derbymatch/features/auth/widgets/kakao_login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/enums/login_platform_enum.dart';
import '../../../core/constants/constants.dart';
import '../../../core/values/values.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginScreen> {
  LoginPlatform _loginPlatform = LoginPlatform.none;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(AppSpaceSize.mediumSize),
          child: Column(
            children: <Widget>[
              Spacer(
                flex: 1,
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
              Container(
                child: KaKaoLoginButton(),
              ),
              Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
