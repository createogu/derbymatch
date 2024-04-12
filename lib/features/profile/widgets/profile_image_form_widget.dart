import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:derbymatch/core/common/models/AttachFileModel.dart';
import 'package:derbymatch/core/constants/constants.dart';
import 'package:derbymatch/core/theme/pallete.dart';
import 'package:derbymatch/core/values/values.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/controllers/FileController.dart';
import '../../auth/controllers/user_me_controller.dart';
import '../../auth/models/user_model.dart';

class ProfileImageFormWidget extends ConsumerStatefulWidget {
  final Function goNextPage;
  final Function goPrevPage;

  const ProfileImageFormWidget({
    required this.goNextPage,
    required this.goPrevPage,
    super.key,
  });

  @override
  ConsumerState<ProfileImageFormWidget> createState() =>
      _ProfileImageFormWidgetState();
}

class _ProfileImageFormWidgetState
    extends ConsumerState<ProfileImageFormWidget> {
  File? profileFile;
  late String profile_image_path;

  @override
  void initState() {
    super.initState();
    final userModel = ref.read(userMeProvider) as UserModel;
    profile_image_path = userModel.profile_image;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _selectProfileImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        profileFile = File(result.files.single.path!);
      });
      AttachFileModel attachFileModel = await ref
          .read(fileControllerProvider.notifier)
          .uploadSingleFile([File(result.files.single.path!)]);

      setState(() {
        profile_image_path = attachFileModel.display_path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userModel = ref.read(userMeProvider) as UserModel;
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Text('${userModel.name}님 프로필 사진을 등록해 주세요!',
                textAlign: TextAlign.left,
                style: AppTextStyles.headlineTextStyle),
          ),
          Expanded(
            flex: 3,
            child: profileFile != null
                ? GestureDetector(
                    onTap: _selectProfileImage,
                    child: CircleAvatar(
                      backgroundImage: FileImage(profileFile!),
                      radius: MediaQuery.of(context).size.width,
                    ))
                : GestureDetector(
                    onTap: _selectProfileImage,
                    child: userModel.profile_image.length != 0
                        ? FutureBuilder<String>(
                            future: ref
                                .read(fileControllerProvider.notifier)
                                .getImageUrl(userModel.profile_image),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasData) {
                                  return CircleAvatar(
                                    backgroundImage: CachedNetworkImageProvider(
                                        snapshot.data!),
                                    radius: MediaQuery.of(context).size.width,
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('이미지를 로드하는 데 실패했습니다.');
                                }
                              }
                              return CircularProgressIndicator();
                            },
                          )
                        : CircleAvatar(
                            backgroundImage: AssetImage(userModel.gender == '01'
                                ? Constants.maleDefaultProfileImagePath
                                : Constants.femaleDefaultProfileImagePath),
                            radius: MediaQuery.of(context).size.width,
                          ),
                  ),
          ),
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width / 3,
            child: TextButton(
              onPressed: () {
                setState(() {
                  profileFile = null;
                });
              },
              child: Text("초기화",
                  style: AppTextStyles.bodyTextStyle
                      .copyWith(color: Pallete.primaryColor)),
              style: ButtonStyles.textButton,
            ),
          ),
          Spacer(
            flex: 1,
          ),
          Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: TextButton(
                    onPressed: () {
                      widget.goPrevPage();
                    },
                    child: Text("이전",
                        style: AppTextStyles.bodyTextStyle
                            .copyWith(color: Pallete.primaryColor)),
                    style: ButtonStyles.seconderyButton,
                  ),
                ),
                AppSpacesBox.horizontalSpaceSmall,
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () async {
                      String profilePath;
                      if (profileFile == null) {
                        profilePath = userModel.gender == '01'
                            ? Constants.maleDefaultProfileImagePath
                            : Constants.femaleDefaultProfileImagePath;
                      } else {
                        profilePath = profileFile!.path;
                      }

                      await ref.read(userMeProvider.notifier).editUserModel(
                            isSave: false,
                            userModel: userModel.copyWith(
                                profile_image: profile_image_path),
                          );

                      // 다음 페이지로 이동
                      widget.goNextPage();
                    },
                    child: Text(
                      "다음",
                      style: AppTextStyles.bodyTextStyle
                          .copyWith(color: Pallete.whiteColor),
                    ),
                    style: ButtonStyles.primaryButton,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: AppSpaceSize.xlargeSize,
          ),
        ],
      ),
    );
  }
}
