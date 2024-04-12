import 'package:derbymatch/features/court/screens/court_list_screen.dart';
import 'package:derbymatch/features/court/screens/court_main_screen.dart';
import 'package:flutter/material.dart';

class MatchMainScreen extends StatefulWidget {
  const MatchMainScreen({super.key});

  @override
  State<MatchMainScreen> createState() => _MatchMainScreenState();
}

class _MatchMainScreenState extends State<MatchMainScreen> {
  @override
  Widget build(BuildContext context) {
    return CourtMainScreen();
  }
}
