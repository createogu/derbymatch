import 'dart:io';

import 'package:derbymatch/core/common/models/AttachFileModel.dart';
import 'package:derbymatch/core/common/widgets/image/common_circle_image_view.dart';
import 'package:derbymatch/core/constants/constants.dart';
import 'package:derbymatch/core/theme/pallete.dart';
import 'package:derbymatch/core/values/values.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/common/controllers/FileController.dart';
import '../../controllers/TeamCreateController.dart';

class TeamLogoImageFormWidget extends ConsumerStatefulWidget {
  final Function goNextPage;
  final Function goPrevPage;

  const TeamLogoImageFormWidget({
    required this.goNextPage,
    required this.goPrevPage,
    super.key,
  });

  @override
  ConsumerState<TeamLogoImageFormWidget> createState() =>
      _ProfileImageFormWidgetState();
}

class _ProfileImageFormWidgetState
    extends ConsumerState<TeamLogoImageFormWidget> {
  File? teamLogoFile;
  late String team_logo_image_path;

  @override
  void initState() {
    super.initState();
    final teamModel = ref.read(teamCreateProvider);
    team_logo_image_path = teamModel.team_logo_image;
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
        teamLogoFile = File(result.files.single.path!);
      });
      AttachFileModel attachFileModel = await ref
          .read(fileControllerProvider.notifier)
          .uploadSingleFile([File(result.files.single.path!)]);

      setState(() {
        team_logo_image_path = attachFileModel.display_path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final teamModel = ref.read(teamCreateProvider);
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${teamModel.name} 팀의\n로고를 등록해 주세요!',
                    textAlign: TextAlign.left,
                    style: AppTextStyles.titleTextStyle),
                Text('(없다면 생략할 수 있어요)',
                    textAlign: TextAlign.left,
                    style: AppTextStyles.infoTextStyle),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: teamLogoFile != null
                ? GestureDetector(
                    onTap: _selectProfileImage,
                    child: CircleAvatar(
                      backgroundImage: FileImage(teamLogoFile!),
                      radius: MediaQuery.of(context).size.width,
                    ))
                : GestureDetector(
                    onTap: _selectProfileImage,
                    child: teamModel.team_logo_image.length != 0
                        ? CommonCircleImageView(
                            profileImage: teamModel.team_logo_image,
                            userName: teamModel.name,
                            radius: MediaQuery.of(context).size.width,
                          )
                        : CircleAvatar(
                            backgroundImage: AssetImage(
                                Constants.femaleDefaultProfileImagePath),
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
                  teamLogoFile = null;
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
                      if (teamLogoFile == null) {
                        profilePath = Constants.femaleDefaultProfileImagePath;
                      } else {
                        profilePath = teamLogoFile!.path;
                      }

                      await ref.read(teamCreateProvider.notifier).editTeamModel(
                            isSave: false,
                            teamModel: teamModel.copyWith(
                                team_logo_image: team_logo_image_path),
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
