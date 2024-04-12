import 'package:flutter/material.dart';

class CommunityMainScreen extends StatefulWidget {
  const CommunityMainScreen({super.key});

  @override
  State<CommunityMainScreen> createState() => _CommunityMainScreenState();
}

class _CommunityMainScreenState extends State<CommunityMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('커뮤니티 메인 화면'),
      ),
    );
  }
}
