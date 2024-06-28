import 'package:derbymatch/core/theme/pallete.dart';
import 'package:derbymatch/core/values/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../controllers/post_controller.dart';
import '../models/post_model.dart';

class PostListCard extends ConsumerStatefulWidget {
  final PostModel post;

  const PostListCard({
    required this.post,
    super.key,
  });

  @override
  ConsumerState<PostListCard> createState() => _PostListCardState();
}

class _PostListCardState extends ConsumerState<PostListCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Routemaster.of(context).push('/community/${widget.post.post_id}');
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // CommonCircleImageView(
                //   profileImage: post.writer.profile_image,
                //   radius: 18,
                //   userName: post.writer.name,
                // ),
                // AppSpacesBox.horizontalSpaceSmall,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.post.channel_name, // 사용자 이름
                        style: AppTextStyles.cautionTextStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Text(
              widget.post.title, // 트윗 내용
              maxLines: 1, // 최대 3줄로 제한
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodyTextStyle.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            AppSpacesBox.horizontalSpaceMicro,
            Row(
              children: [
                Text(
                  widget.post.writer.name, // 사용자 이름
                  style: AppTextStyles.cautionTextStyle.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                AppSpacesBox.horizontalSpaceMicro,
                Text(
                  timeago.format(widget.post.created_at, locale: 'ko'),
                  // 사용자 이름
                  style: AppTextStyles.cautionTextStyle.copyWith(
                    color: Pallete.greyColor.withOpacity(0.8),
                  ),
                )
              ],
            ),
            AppSpacesBox.verticalSpaceSmall,
            if (widget.post.content.isNotEmpty)
              Text(
                widget.post.content,
                style: AppTextStyles.infoTextStyle,
                maxLines: 3, // 최대 3줄로 제한
                overflow: TextOverflow.ellipsis, // 내용이 넘치면 ... 처리
              ),
            AppSpacesBox.verticalSpaceMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () async {
                      await ref
                          .read(postControllerProvider(widget.post.post_id)
                              .notifier)
                          .toggleLike();
                    },
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        Icon(
                            widget.post.is_like
                                ? Icons.favorite_outlined
                                : Icons.favorite_border,
                            size: 20,
                            color: widget.post.is_like
                                ? Pallete.primaryColor
                                : Pallete.greyColor),
                        SizedBox(width: 5),
                        Text(
                          widget.post.like_cnt.toString(), // 좋아요 수
                          style: TextStyle(color: Pallete.greyColor),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Icon(Icons.remove_red_eye_outlined,
                          size: 20, color: Pallete.greyColor),
                      SizedBox(width: 5),
                      Text(
                        '${widget.post.view_cnt}', // 댓글 수 또는 조회 수
                        style: TextStyle(color: Pallete.greyColor),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Icon(Icons.chat_bubble_outline,
                          size: 20, color: Pallete.greyColor),
                      SizedBox(width: 5),
                      Text(
                        '${widget.post.comment_cnt}', // 댓글수
                        style: TextStyle(color: Pallete.greyColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
