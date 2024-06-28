import 'package:derbymatch/core/values/values.dart';
import 'package:derbymatch/features/player/models/player_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../../core/common/controllers/CommCodeController.dart';
import '../../../core/common/widgets/image/common_circle_image_view.dart';
import '../models/post_model.dart';

class PostWriterSection extends ConsumerWidget {
  final PlayerModel writer;

  const PostWriterSection({
    super.key,
    required this.writer,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commCodeController = ref.read(commCodeControllerProvider.notifier);

    return GestureDetector(
      onTap: () {
        Routemaster.of(context).push('/player/${writer.user_id}');
      },
      child: Row(
        children: [
          CommonCircleImageView(
            profileImage: writer.profile_image,
            radius: 14,
            userName: writer.name,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  writer.name, // 사용자 이름
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
