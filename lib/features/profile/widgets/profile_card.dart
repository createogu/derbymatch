import 'package:derbymatch/features/auth/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../../core/common/widgets/image/common_rectangle_image_view.dart';
import '../../../core/theme/pallete.dart';
import '../../../core/values/values.dart';

class ProfileCard extends ConsumerWidget {
  final UserModel userModel;

  const ProfileCard({required this.userModel, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (userModel.name != null && userModel.name!.isNotEmpty) {
      return Card(
        elevation: 5,
        color: Pallete.primaryColor,
        child: Padding(
          padding: EdgeInsets.all(AppSpaceSize.largeSize),
          child: ListTile(
            contentPadding: EdgeInsets.zero, // 여기를 추가합니다.
            // leading: CommonCircleImageView(
            //   profile_image: userModel.profile_image,
            //   radius: 30,
            // ),
            title: Text(
              '반가워요,\n${userModel.name!}님',
              style: AppTextStyles.headerTextStyle.copyWith(),
            ),
            subtitle: Text(
              '프로필 관리 >',
              style: AppTextStyles.infoTextStyle.copyWith(
                color: Pallete.whiteColor,
              ),
            ),
          ),
        ),
      );
    } else {
      return Card(
        elevation: 0,
        color: Pallete.redColor,
        surfaceTintColor: Pallete.whiteColor,
        child: SizedBox(
          width: double.infinity,
          height: 200,
          child: Column(
            children: [
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Pallete.primaryColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(
                      10,
                    ),
                  ),
                ),
                padding: EdgeInsets.all(AppSpaceSize.smallSize),
                // 헤더의 배경색을 설정합니다.
                child: Icon(
                  Icons.dangerous_outlined,
                  color: Pallete.whiteColor,
                ),
              ),
              AppSpacesBox.verticalSpaceMedium,
              Expanded(
                flex: 1,
                child: Text(
                  '아직 선수카드를 생성하지 않았어요.\n선수카드가 없으면 서비스 이용에 제한이 있어요',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.infoTextStyle
                      .copyWith(color: Pallete.redColor),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(AppSpaceSize.mediumSize),
                  child: ElevatedButton(
                      onPressed: () {
                        Routemaster.of(context).push('/createUserProfile');
                      },
                      child: Text(
                        '선수카드 생성',
                        style: AppTextStyles.bodyTextStyle
                            .copyWith(color: Pallete.whiteColor),
                      ),
                      style: ButtonStyles.primaryButton),
                ),
              )
            ],
          ),
        ),
      );
    }
    ;
  }
}
