import 'package:flutter/material.dart';

import '../../../../../features/auth/models/user_model.dart';
import '../../../../theme/pallete.dart';
import '../../../../values/values.dart';

class SearchAddressBar extends StatelessWidget {
  const SearchAddressBar({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42, // 높이 설정
      child: GestureDetector(
        onTap: () {},
        child: TextField(
          readOnly: true,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.location_on,
              color: Pallete.primaryColor,
            ),
            hintText: user.addressName,
            contentPadding:
                EdgeInsets.symmetric(vertical: AppSpaceSize.mediumSize),
            // 패딩 조정
            border: OutlineInputBorder(
              // 기본 테두리
              borderSide: BorderSide(color: Pallete.primaryColor),
              borderRadius:
                  BorderRadius.all(Radius.circular(AppSpaceSize.mediumSize)),
            ),
            enabledBorder: OutlineInputBorder(
              // 활성화되지 않았을 때의 테두리
              borderSide: BorderSide(color: Pallete.primaryColor),
              borderRadius:
                  BorderRadius.all(Radius.circular(AppSpaceSize.mediumSize)),
            ),
            focusedBorder: OutlineInputBorder(
              // 포커스 받았을 때의 테두리
              borderSide: BorderSide(color: Pallete.primaryColor),
              borderRadius:
                  BorderRadius.all(Radius.circular(AppSpaceSize.mediumSize)),
            ),
          ),
          style: AppTextStyles.infoTextStyle,
        ),
      ),
    );
  }
}
