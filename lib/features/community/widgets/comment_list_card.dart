import 'package:derbymatch/core/theme/pallete.dart';
import 'package:derbymatch/core/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../controllers/comment_controller.dart';
import '../models/comment_model.dart';

class CommentListCard extends ConsumerStatefulWidget {
  final CommentModel comment;

  const CommentListCard({
    required this.comment,
    super.key,
  });

  @override
  ConsumerState<CommentListCard> createState() => _CommentListCardState();
}

class _CommentListCardState extends ConsumerState<CommentListCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Routemaster.of(context).push(
            '/community/${widget.comment.post_id}/${widget.comment.comment_id}');
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  widget.comment.commenter.name, // 사용자 이름
                  style: AppTextStyles.cautionTextStyle.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                AppSpacesBox.horizontalSpaceMicro,
                Text(
                  timeago.format(widget.comment.created_at, locale: 'ko'),
                  // 사용자 이름
                  style: AppTextStyles.cautionTextStyle.copyWith(
                    color: Pallete.greyColor.withOpacity(0.8),
                  ),
                )
              ],
            ),
            AppSpacesBox.verticalSpaceSmall,
            if (widget.comment.content.isNotEmpty)
              Text(
                widget.comment.content,
                style: AppTextStyles.infoTextStyle,
                maxLines: 3, // 최대 3줄로 제한
                overflow: TextOverflow.ellipsis, // 내용이 넘치면 ... 처리
              ),
            AppSpacesBox.verticalSpaceMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {
                    // 상태 업데이트를 위한 API 호출
                    bool success = await ref
                        .read(
                            commentControllerProvider(widget.comment.comment_id)
                                .notifier)
                        .toggleLike();
                    if (success) {
                    } else {
                      // 실패 처리, 사용자에게 오류 메시지를 표시할 수 있습니다.
                      print("Failed to toggle like");
                    }
                  },
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Icon(
                          widget.comment.is_like
                              ? Icons.favorite_outlined
                              : Icons.favorite_border,
                          size: 20,
                          color: widget.comment.is_like
                              ? Pallete.primaryColor
                              : Pallete.greyColor),
                      SizedBox(width: 2),
                      Text(
                        widget.comment.like_cnt.toString(), // 좋아요 수
                        style: AppTextStyles.cautionTextStyle,
                      ),
                    ],
                  ),
                ),
                AppSpacesBox.horizontalSpaceSmall,
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    Text(
                      widget.comment.reply_cnt > 0
                          ? widget.comment.reply_cnt.toString()
                          : '', // 댓글수
                      style: AppTextStyles.cautionTextStyle,
                    ),
                    GestureDetector(
                      onTap: () {
                        Routemaster.of(context).push(
                            '/community/${widget.comment.post_id}/${widget.comment.comment_id}');
                      },
                      child: Text(
                        widget.comment.reply_cnt > 0 ? '답글보기' : ' 답글달기', // 댓글수
                        style: AppTextStyles.cautionTextStyle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
