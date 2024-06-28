import 'package:derbymatch/core/common/widgets/divider/common_divider.dart';
import 'package:derbymatch/core/theme/pallete.dart';
import 'package:derbymatch/core/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/widgets/image/common_circle_image_view.dart';
import '../controllers/post_controller.dart';
import '../models/post_model.dart';

class PostCard extends ConsumerStatefulWidget {
  final PostModel post;

  const PostCard({
    required this.post,
    super.key,
  });

  @override
  ConsumerState<PostCard> createState() => _PostCardState();
}

class _PostCardState extends ConsumerState<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _writerSection(),
          AppSpacesBox.verticalSpaceSmall,
          Text(
            widget.post.title, // 트윗 내용
            style: AppTextStyles.headlineTextStyle.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.post.channel_name, // 채널 이름
                style: AppTextStyles.infoTextStyle
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              AppSpacesBox.horizontalSpaceMicro,
              Text(
                utils().dateTimeToString2(widget.post.created_at), // 사용자 이름
                style: AppTextStyles.cautionTextStyle.copyWith(
                  color: Pallete.greyColor.withOpacity(0.8),
                ),
              ),
            ],
          ),
          CommonDivider(),
          Text(
            widget.post.content,
            style: AppTextStyles.infoTextStyle.copyWith(height: 1.5),
          ),
          CommonDivider(),
          _postActionSction(),
        ],
      ),
    );
  }

  Container _postActionSction() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () async {
                // 상태 업데이트를 위한 API 호출
                await ref
                    .read(postControllerProvider(widget.post.post_id).notifier)
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
                  AppSpacesBox.horizontalSpaceMicro,
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
                AppSpacesBox.horizontalSpaceMicro,
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
                AppSpacesBox.horizontalSpaceMicro,
                Text(
                  '${widget.post.comment_cnt}', // 댓글수
                  style: TextStyle(color: Pallete.greyColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _writerSection() {
    return Container(
      height: 40,
      child: Row(
        children: [
          CommonCircleImageView(
            profileImage: widget.post.writer.profile_image,
            radius: 24,
            userName: widget.post.writer.name,
          ),
          AppSpacesBox.horizontalSpaceMicro,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.post.writer.name, // 사용자 이름
                style: AppTextStyles.infoTextStyle.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                widget.post.writer.addressName, // 사용자 이름
                style: AppTextStyles.cautionTextStyle
                    .copyWith(color: Pallete.greyColor.withOpacity(1)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
