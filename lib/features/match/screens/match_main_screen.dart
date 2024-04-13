import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class MatchMainScreen extends StatefulWidget {
  const MatchMainScreen({super.key});

  @override
  State<MatchMainScreen> createState() => _MatchMainScreenState();
}

class _MatchMainScreenState extends State<MatchMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: TextButton(
          onPressed: () {
            Routemaster.of(context).push('/createMatch');
          },
          child: Text('매치생성'),
        ),
      ),
    );
  }
}
