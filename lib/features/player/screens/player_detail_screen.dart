import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../../../core/common/widgets/image/common_circle_image_view.dart';
import '../../../../core/theme/pallete.dart';
import '../../../../core/values/values.dart';
import '../controllers/PlayerController.dart';
import '../models/player_model.dart';

class PlayerDetailScreen extends ConsumerStatefulWidget {
  const PlayerDetailScreen({super.key});

  @override
  ConsumerState<PlayerDetailScreen> createState() => _PlayerDetailScreenState();
}

class _PlayerDetailScreenState extends ConsumerState<PlayerDetailScreen> {
  late Future<PlayerModel> playerDetailFuture;
  int? user_id;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    user_id = int.parse(RouteData.of(context).pathParameters['user_id']!);
    playerDetailFuture =
        ref.read(PlayerControllerProvider.notifier).getPlayerDetail(user_id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('선수 정보'),
      ),
      body: FutureBuilder<PlayerModel>(
        future: playerDetailFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No player data available'));
          } else {
            final player = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(AppSpaceSize.largeSize),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonCircleImageView(
                      profileImage: player.profile_image,
                      radius: 80,
                      userName: player.name,
                    ),
                    SizedBox(height: AppSpaceSize.mediumSize),
                    Text(player.name, style: TextStyle(fontSize: 20)),
                    SizedBox(height: AppSpaceSize.smallSize),
                    Text(
                        'Gender: ${player.gender_cd == '01' ? 'Male' : 'Female'}'),
                    SizedBox(height: AppSpaceSize.smallSize),
                    Text(
                        'Height: ${player.height} cm, Weight: ${player.weight} kg'),
                    SizedBox(height: AppSpaceSize.mediumSize),
                    Wrap(
                      spacing: AppSpaceSize.smallSize,
                      children: player.positions
                          .map((position) => Chip(
                                label: Text(position),
                                backgroundColor: Pallete.seconderyColor,
                              ))
                          .toList(),
                    ),
                    SizedBox(height: AppSpaceSize.smallSize),
                    Text('Division: ${player.division_nm}'),
                    SizedBox(height: AppSpaceSize.mediumSize),
                    Text('Address: ${player.addressName}'),
                    SizedBox(height: AppSpaceSize.smallSize),
                    Text('Introduce: ${player.introduce}'),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
