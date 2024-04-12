import 'dart:io';

import 'package:derbymatch/core/theme/pallete.dart';
import 'package:derbymatch/core/values/values.dart';
import 'package:derbymatch/features/team/command/team_photo_commandl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/controllers/FileController.dart';
import '../../../../core/common/models/AttachFileModel.dart';
import '../../controllers/TeamController.dart';

class TeamPhotoFormWidget extends ConsumerStatefulWidget {
  final int team_id;

  const TeamPhotoFormWidget({required this.team_id, super.key});

  @override
  ConsumerState<TeamPhotoFormWidget> createState() =>
      _TeamPhotoFormWidgetState();
}

class _TeamPhotoFormWidgetState extends ConsumerState<TeamPhotoFormWidget> {
  List<File> _selectedPhotos = [];
  List<String> _uploadedPhotoPaths = [];

  void _pickPhotos() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
      withData: true,
    );

    if (result != null) {
      List<File> pickedFiles = result.paths.map((path) => File(path!)).toList();
      if (pickedFiles.length > 10) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('최대 10장의 이미지만 선택할 수 있습니다.'),
            backgroundColor: Colors.red,
          ),
        );
        pickedFiles = pickedFiles.take(10).toList();
      }

      setState(() {
        _selectedPhotos.addAll(pickedFiles);
      });

      // 서버에 이미지 업로드하고 경로 받아오는 부분
      for (var photo in pickedFiles) {
        AttachFileModel attachFileModel = await ref
            .read(fileControllerProvider.notifier)
            .uploadSingleFile([photo]);

        setState(() {
          _uploadedPhotoPaths.add(attachFileModel.display_path);
        });
      }
    }
  }

  void _deletePhoto(int index) {
    setState(() {
      _selectedPhotos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '팀 사진 등록',
          style: AppTextStyles.headlineTextStyle,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_a_photo),
            onPressed: _pickPhotos,
          ),
        ],
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(AppSpaceSize.mediumSize),
          child: Column(
            children: [
              _selectedPhotos.isEmpty
                  ? Expanded(
                      flex: 5,
                      // 여기서 Expanded 추가
                      child: Center(
                        child: Text(
                          '추가된 사진이 없습니다.',
                          style: AppTextStyles.bodyTextStyle,
                        ),
                      ),
                    )
                  : Expanded(
                      flex: 5,
                      // 여기서 Expanded 추가
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 5.0,
                          crossAxisSpacing: 5.0,
                        ),
                        itemCount: _selectedPhotos.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3,
                                height: MediaQuery.of(context).size.height / 3,
                                child: Image.file(
                                  _selectedPhotos[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AppSpaceSize.smallSize),
                                  color: Pallete.greyColor.withOpacity(0.5),
                                  child: Text(
                                    '${index + 1}',
                                    style: AppTextStyles.infoTextStyle
                                        .copyWith(color: Pallete.whiteColor),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: IconButton(
                                  icon: Icon(Icons.cancel, color: Colors.red),
                                  onPressed: () => _deletePhoto(index),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    TeamPhotoCommand teamPhotoCommand = new TeamPhotoCommand(
                        team_id: widget.team_id,
                        image_path: _uploadedPhotoPaths);
                    await ref
                        .read(TeamControllerProvider.notifier)
                        .addTeamPhotos(teamPhotoCommand);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    '추가',
                    style: AppTextStyles.bodyTextStyle
                        .copyWith(color: Pallete.whiteColor),
                  ),
                  style: ButtonStyles.primaryButton,
                ),
              ),
              SizedBox(height: AppSpaceSize.mediumSize),
            ],
          ),
        ),
      ),
    );
  }
}
