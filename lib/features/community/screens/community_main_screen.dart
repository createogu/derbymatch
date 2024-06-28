import 'package:derbymatch/features/community/screens/post_list_screen.dart';
import 'package:derbymatch/features/community/widgets/channel_filter_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class CommunityMainScreen extends StatefulWidget {
  const CommunityMainScreen({super.key});

  @override
  State<CommunityMainScreen> createState() => _CommunityMainScreenState();
}

class _CommunityMainScreenState extends State<CommunityMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 50,
          child: ChannelFilterBar(),
        ),
        Expanded(
          flex: 3,
          child: PostListScreen(),
        ),
      ],
    );
  }
}
