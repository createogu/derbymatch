import 'package:derbymatch/core/theme/pallete.dart';
import 'package:derbymatch/core/values/values.dart';
import 'package:derbymatch/features/community/commands/post_command.dart';
import 'package:derbymatch/features/community/controllers/channel_controller.dart';
import 'package:derbymatch/features/community/controllers/post_list_controller.dart';
import 'package:derbymatch/features/community/models/channel_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../../core/common/widgets/bottomSheer/drag_indicator.dart';
import '../../../core/common/widgets/textFormField/common_text_form_field.dart';
import '../../../core/common/widgets/textFormField/scroll_text_form_field.dart';
import '../../../core/layout/form_screen_layout.dart';

class CreatePostScreen extends ConsumerStatefulWidget {
  const CreatePostScreen({super.key});

  @override
  ConsumerState<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<CreatePostScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  late List<ChannelModel> myChannelList = [];
  final List<String> _tags = [];
  ChannelModel? _selectedChannel;
  bool _canRegister = false;

  @override
  void initState() {
    super.initState();
    _loadMyChannelList();
    _tagController.addListener(_handleTagInput);
    _titleController.addListener(_updateCanRegister);
    _bodyController.addListener(_updateCanRegister);
  }

  // initState에서 호출할 별도의 비동기 메소드 생성
  Future<void> _loadMyChannelList() async {
    myChannelList =
        await ref.read(channelControllerProvider.notifier).getMyChannelList();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  void _updateCanRegister() {
    setState(() {
      _canRegister = _validateRegistration();
    });
  }

  bool _validateRegistration() {
    // 제목과 본문이 공백이 아닌지 검사하고, 채널도 선택되었는지 확인
    return _selectedChannel != null &&
        _titleController.text.trim().isNotEmpty &&
        _bodyController.text.trim().isNotEmpty;
  }

  void _handleTagInput() {
    String trimmedText = _tagController.text.trim();
    // 태그 리스트가 5개 미만일 때만 태그 추가 로직을 실행
    if (trimmedText.isNotEmpty &&
        _tagController.text.endsWith(' ') &&
        _tags.length < 5) {
      setState(() {
        _tags.add(trimmedText);
        _tagController.clear();
      });
    }
  }

  void _selectChannel(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Pallete.whiteColor,
      elevation: 0,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(AppSpaceSize.defaultSize),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DragIndicator(),
              Flexible(
                child: ListView(
                  children: _getChannelItems(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _getChannelItems() {
    List<Widget> items = [];
    String? lastChannelType;

    for (var channel in myChannelList) {
      // channel_type이 변경됐다면 새로운 섹션의 제목을 추가
      if (lastChannelType == null || lastChannelType != channel.channel_type) {
        String title = _getTitleForChannelType(channel.channel_type);
        items.add(
          Text(title,
              style: AppTextStyles.bodyTextStyle.copyWith(
                color: Pallete.greyColor,
                fontWeight: FontWeight.w700,
              )),
        ); // 제목 스타일 설정
      }
      items.add(_buildChannelItem(channel)); // 채널 아이템 추가
      lastChannelType = channel.channel_type; // 마지막 channel_type 업데이트
    }

    return items;
  }

  String _getTitleForChannelType(String channelType) {
    switch (channelType) {
      case '01':
        return '토픽';
      case '02':
        return '소속팀';
      case '03':
        return '소속지역';
      default:
        return '기타';
    }
  }

  Widget _buildChannelItem(ChannelModel channelModel) {
    // isSelected를 계산하기 전에 _selectedChannel이 null인지 확인
    bool isSelected = _selectedChannel != null &&
        _selectedChannel!.channel_id == channelModel.channel_id;

    return ListTile(
      title:
          Text(channelModel.channel_name, style: AppTextStyles.infoTextStyle),
      tileColor: isSelected ? Pallete.primaryColor.withOpacity(0.2) : null,
      onTap: () {
        setState(() {
          _selectedChannel = channelModel;
          Navigator.pop(context);
        });
      },
    );
  }

  Future<void> submitPost() async {
    PostCommand postCommand = PostCommand(
        channel_id: _selectedChannel!.channel_id,
        title: _titleController.text,
        content: _bodyController.text,
        tags: _tags);
    bool isSuccess = await ref
        .read(postListControllerProvider.notifier)
        .createPost(postCommand);

    if (isSuccess) {
      // 성공적으로 등록되면 다른 페이지로 라우트
      Routemaster.of(context).replace('/community');
    } else {
      // 실패 알림 처리
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to create the post.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormScreenLayout(
      title: '새 글 작성',
      content: '작성중인 글을 삭제하시겠습니까?',
      canRegister: _canRegister,
      onRegister: () {
        if (_canRegister) {
          submitPost();
        }
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildChannelSelector(context),
            AppSpacesBox.verticalSpaceMedium,
            CommonTextFormField(
              controller: _titleController,
              placeholder: '제목을 입력해주세요',
              keyboardType: 'text',
              obscureText: false,
              textFocus: FocusNode(),
            ),
            AppSpacesBox.verticalSpaceMedium,
            ScrollTextFormField(
              controller: _bodyController,
              parentHeight: MediaQuery.of(context).size.height,
            ),
            AppSpacesBox.verticalSpaceMedium,
            TextFormField(
              controller: _tagController,
              style: AppTextStyles.infoTextStyle,
              maxLength: 10,
              readOnly: _tags.length >= 5,
              // 태그가 5개일 때 입력 필드를 읽기 전용으로 설정
              decoration: AppInputStyles.defaultFormFieldStyle.copyWith(
                hintStyle: AppTextStyles.infoTextStyle,
                hintText: '태그(띄어쓰기로 추가, 5개 까지)',
                suffixIcon: _tags.length >= 5
                    ? Icon(Icons.block, color: Pallete.primaryColor)
                    : null,
              ),
            ),
            Wrap(
              spacing: AppSpaceSize.mediumSize,
              children: _tags.map((tag) => _buildTagChip(tag)).toList(),
            ),
            // _buildImagePicker(),
          ],
        ),
      ),
    );
  }

  Widget _buildChannelSelector(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectChannel(context),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Pallete.greyColor.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(AppSpaceSize.smallSize),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_selectedChannel != null
                ? _selectedChannel!.channel_name
                : '채널 선택'),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }

  Widget _buildTagChip(String tag) {
    return Chip(
      backgroundColor: Pallete.primaryColor.withOpacity(0.1),
      elevation: 0,
      side: BorderSide(color: Pallete.whiteColor),
      label: Text(tag,
          style: AppTextStyles.cautionTextStyle.copyWith(
              color: Pallete.primaryColor, fontWeight: FontWeight.w700)),
      onDeleted: () {
        setState(() {
          _tags.remove(tag);
        });
      },
      deleteIconColor: Pallete.primaryColor,
    );
  }
}
