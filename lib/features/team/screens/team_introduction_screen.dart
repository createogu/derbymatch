import 'package:derbymatch/core/common/widgets/divider/title_divider.dart';
import 'package:derbymatch/core/values/values.dart';
import 'package:derbymatch/features/team/controllers/TeamController.dart';
import 'package:derbymatch/features/team/models/team_model.dart';
import 'package:derbymatch/features/team/models/team_photo_model.dart';
import 'package:derbymatch/features/team/models/team_schedule_info_model.dart';
import 'package:derbymatch/features/team/widgets/form/team_introduction_form_widget.dart';
import 'package:derbymatch/features/team/widgets/form/team_schedule_info_form_widget.dart';
import 'package:derbymatch/features/team/widgets/view/team_schedule_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/common/controllers/CommCodeController.dart';
import '../../../core/common/widgets/bottomSheer/open_bottom_sheet.dart';
import '../../../core/common/widgets/image/common_full_screen_image.dart';
import '../../../core/common/widgets/image/common_rectangle_image_view.dart';
import '../widgets/form/team_photo_form_widget.dart';

class TeamIntroductionScreen extends ConsumerStatefulWidget {
  final TeamModel teamModel;

  const TeamIntroductionScreen({required this.teamModel, super.key});

  @override
  _TeamIntroductionScreenState createState() => _TeamIntroductionScreenState();
}

class _TeamIntroductionScreenState
    extends ConsumerState<TeamIntroductionScreen> {
  late final teamController = ref.watch(TeamControllerProvider.notifier);
  late final commCodeController =
      ref.watch(commCodeControllerProvider.notifier);

  Widget infoSection(String title, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(title, style: AppTextStyles.bodyTextStyle),
          SizedBox(height: 8),
          Text(value, style: AppTextStyles.infoTextStyle),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(AppSpaceSize.mediumSize),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TitleDivider(
              title: '📣 팀 소개',
              leadingButton: Container(
                height: 40,
                child: OpenBottomSheet(
                  heightRatio: 0.8,
                  child:
                      TeamIntroductionFormWidget(teamModel: widget.teamModel),
                ),
              ),
            ),
            Row(
              children: [
                infoSection('창립년도', '${widget.teamModel.since_year}년'),
                infoSection('활동지역', widget.teamModel.addressName),
                infoSection(
                    '부종',
                    commCodeController.getCommCodeName(
                            'division', widget.teamModel.division) ??
                        '정보 없음'),
              ],
            ),
            SizedBox(height: 20),
            Container(
              alignment: Alignment.topLeft,
              child: Text(widget.teamModel.introduce,
                  style: AppTextStyles.infoTextStyle),
            ),
            SizedBox(height: 20),
            TitleDivider(
              title: '⏰ 정기모임',
              leadingButton: Container(
                height: 40,
                child: OpenBottomSheet(
                  heightRatio: 0.8,
                  child: TeamScheduleInfoFormWidget(
                      team_id: widget.teamModel.team_id),
                ),
              ),
            ),
            teamInfoSection(
                teamController.getTeamSchedules(widget.teamModel.team_id),
                '일정',
                buildScheduleWidget),
            AppSpacesBox.verticalSpaceMedium,
            TitleDivider(
              title: '📷 사진',
              leadingButton: Container(
                height: 40,
                child: OpenBottomSheet(
                  heightRatio: 0.8,
                  child: TeamPhotoFormWidget(team_id: widget.teamModel.team_id),
                ),
              ),
            ),
            teamInfoSection(
                teamController.getTeamPhotosList(widget.teamModel.team_id),
                '사진',
                buildPhotoWidget),
            AppSpacesBox.verticalSpaceXlarge,
          ],
        ),
      ),
    );
  }

  Widget teamInfoSection<T>(Future<List<T>> itemsFuture, String type,
      Widget Function(T) buildFunction) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: FutureBuilder<List<T>>(
        future: itemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('오류 발생: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('등록된 $type 이 없습니다.');
          } else {
            return Row(
                children:
                    snapshot.data!.map((item) => buildFunction(item)).toList());
          }
        },
      ),
    );
  }

  Widget buildPhotoWidget(TeamPhotoModel photo) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) =>
              Dialog(child: CommonFullScreenImage(imagePath: photo.image_path)),
        );
      },
      child: Container(
        width: 170,
        child: Padding(
          padding: EdgeInsets.all(AppSpaceSize.smallSize),
          child: CommonSquareImageView(
              profile_image: photo.image_path, size: 150, userName: 'aa'),
        ),
      ),
    );
  }

  Widget buildScheduleWidget(TeamScheduleInfoModel scheduleInfoModel) {
    return Container(
      width: 170,
      child: TeamScheduleInfoCard(
        teamScheduleInfoModel: scheduleInfoModel,
      ),
    );
  }
}
