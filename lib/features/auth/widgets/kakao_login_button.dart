import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk_talk/kakao_flutter_sdk_talk.dart';

import '../../../core/theme/pallete.dart';
import '../../../core/values/values.dart';
import '../controllers/user_me_controller.dart';

class KaKaoLoginButton extends ConsumerWidget {
  const KaKaoLoginButton({Key? key}) : super(key: key);

  Future<dynamic> fn_loginWithKakaoAccount() async {
    try {
      OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
      return token;
    } catch (e) {
      developer.log("로그인 실패 " + e.toString());

      return null;
    }
  }

  Future<dynamic> fn_loginWithKakaoTalk() async {
    try {
      OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
      return token;
    } catch (e) {
      developer.log("로그인 실패 " + e.toString());

      return null;
    }
  }

  Future<dynamic> fn_kakaoLogin() async {
    OAuthToken? token;
    // 카카오톡 설치 여부 확인
    // 카카오톡이 설치되어 있으면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
    if (await isKakaoTalkInstalled()) {
      try {
        token = await fn_loginWithKakaoTalk();
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return false;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          token = await fn_loginWithKakaoAccount();
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      try {
        token = await fn_loginWithKakaoAccount();
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
    return token;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      style: ButtonStyles.kakaoLoginButton,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Icon(
              Icons.chat_bubble_rounded,
              color: Pallete.blackColor,
            ),
          ),
          const Spacer(flex: 2),
          Expanded(
            flex: 8,
            child: Text(
              "카카오톡으로 시작",
              style: AppTextStyles.bodyTextStyle
                  .copyWith(color: Pallete.blackColor),
            ),
          ),
        ],
      ),
      onPressed: () async {
        try {
          OAuthToken token = await fn_kakaoLogin() as OAuthToken;
          if (token != null) {
            await ref.read(userMeProvider.notifier).login(
                  kakao_access_token: token.accessToken,
                );
          }
        } catch (error) {
          print(error);
        }
      },
    );
  }
}
