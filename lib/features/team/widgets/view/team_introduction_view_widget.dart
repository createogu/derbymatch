import 'package:flutter/material.dart';

class TeamIntroductionView extends StatefulWidget {
  const TeamIntroductionView({super.key});

  @override
  State<TeamIntroductionView> createState() => _TeamIntroductionViewState();
}

class _TeamIntroductionViewState extends State<TeamIntroductionView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('팀 홈'),
      ),
    );
  }
}
