import 'package:derbymatch/core/theme/pallete.dart';
import 'package:derbymatch/core/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/channel_controller.dart';
import '../controllers/post_filter_controller.dart';
import '../models/channel_model.dart';

class ChannelFilterBar extends ConsumerStatefulWidget {
  const ChannelFilterBar({super.key});

  @override
  ConsumerState<ChannelFilterBar> createState() => _ChannelFilterBarState();
}

class _ChannelFilterBarState extends ConsumerState<ChannelFilterBar> {
  late List<ChannelModel> myChannelList = [];
  List<int> selectedChannels = []; // 선택된 채널의 인덱스를 관리

  @override
  void initState() {
    super.initState();
    _loadMyChannelList();
  }

  Future<void> _loadMyChannelList() async {
    myChannelList =
        await ref.read(channelControllerProvider.notifier).getMyChannelList();
  }

  @override
  Widget build(BuildContext context) {
    final postFilter = ref.watch(postFilterProvider.notifier);
    final channels = ref.watch(postFilterProvider).channels;
    return Scaffold(
      body: Wrap(
        alignment: WrapAlignment.start, // 왼쪽 정렬
        spacing: AppSpaceSize.smallSize,
        children: List<Widget>.generate(
          myChannelList.length,
          (int index) {
            bool isSelected = true;
            return ChoiceChip(
              selectedColor: Pallete.primaryColor,
              side: isSelected ? null : BorderSide(color: Pallete.primaryColor),
              // 선택되지 않았을 때의 테두리 색상
              checkmarkColor: Pallete.whiteColor,
              // 체크 아이콘 색상
              label: Text(
                myChannelList[index].channel_name,
                style: isSelected
                    ? AppTextStyles.cautionTextStyle
                        .copyWith(color: Pallete.whiteColor)
                    : AppTextStyles.cautionTextStyle
                        .copyWith(color: Pallete.primaryColor),
              ),
              selected: isSelected,
              onSelected: (bool selected) {
                postFilter.updateChannels(myChannelList[index].channel_id);
              },
            );
          },
        ),
      ),
    );
  }
}
