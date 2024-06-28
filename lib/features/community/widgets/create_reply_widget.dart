import 'package:derbymatch/core/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../../core/values/values.dart';
import '../commands/comment_command.dart';
import '../commands/reply_command.dart';
import '../controllers/comment_list_controller.dart';
import '../controllers/reply_list_controller.dart';

class CreateReplyWidget extends ConsumerStatefulWidget {
  final int post_id;
  final int comment_id;

  const CreateReplyWidget({
    required this.post_id,
    required this.comment_id,
    super.key,
  });

  @override
  ConsumerState<CreateReplyWidget> createState() => _CreateReplyScreenState();
}

class _CreateReplyScreenState extends ConsumerState<CreateReplyWidget> {
  final TextEditingController _bodyController = TextEditingController();
  bool _canRegister = false;

  @override
  void initState() {
    super.initState();
    _bodyController.addListener(_updateCanRegister);
  }

  @override
  void dispose() {
    _bodyController.dispose();
    super.dispose();
  }

  void _updateCanRegister() {
    setState(() {
      _canRegister = _validateRegistration();
    });
  }

  bool _validateRegistration() {
    return _bodyController.text.trim().isNotEmpty;
  }

  Future<void> submitReply() async {
    ReplyCommand replyCommand = ReplyCommand(
      post_id: widget.post_id,
      comment_id: widget.comment_id,
      content: _bodyController.text,
    );

    bool isSuccess = await ref
        .read(replyListControllerProvider.notifier)
        .createReply(replyCommand);
    if (isSuccess) {
      _bodyController.text = '';
      Routemaster.of(context).pop();
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to create the comment.'),
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
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _showBottomSheet(context),
      child: Container(
        height: 90,
        width: MediaQuery.of(context).size.width,
        color: Pallete.whiteColor,
        alignment: Alignment.center,
        child: Row(
          children: [
            AppSpacesBox.horizontalSpaceMedium,
            Expanded(
              flex: 3,
              child: Container(
                decoration: AppBoxDecoration.primaryBoxDeco
                    .copyWith(color: Pallete.greyColor.withOpacity(0.05)),
                child: Padding(
                  padding: EdgeInsets.all(AppSpaceSize.mediumSize),
                  child: Text(
                    _bodyController.text.length == 0
                        ? '댓글을 입력해주세요.'
                        : _bodyController.text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.infoTextStyle.copyWith(
                        color: Pallete.greyColor.withOpacity(0.4),
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.send))
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      elevation: 0,
      backgroundColor: Pallete.whiteColor,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.1,
                ),
                child: Padding(
                  padding: EdgeInsets.all(AppSpaceSize.defaultSize),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: TextField(
                          controller: _bodyController,
                          decoration:
                              AppInputStyles.primaryFormFieldStyle.copyWith(
                            hintText: "댓글을 입력하세요",
                            hintStyle: AppTextStyles.infoTextStyle,
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                _bodyController.clear(); // 텍스트 필드를 비웁니다.
                                setModalState(() {
                                  _canRegister =
                                      _validateRegistration(); // 내용이 변경되었으므로 등록 가능 여부를 다시 검증
                                });
                              },
                            ),
                          ),
                          autofocus: true,
                          minLines: 1,
                          maxLines: 5,
                          keyboardType: TextInputType.multiline,
                          onChanged: (value) {
                            setModalState(() {
                              _canRegister = _validateRegistration();
                            });
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: _canRegister
                            ? () {
                                submitReply();
                              }
                            : null,
                        icon: Icon(
                          Icons.send,
                          color: _canRegister
                              ? Pallete.primaryColor
                              : Pallete.greyColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
