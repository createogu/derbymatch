import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../../../core/values/values.dart';
import '../controllers/match_controller.dart';
import '../models/match_model.dart';

class MatchDetailScreen extends ConsumerStatefulWidget {
  const MatchDetailScreen({super.key});

  @override
  ConsumerState<MatchDetailScreen> createState() => _MatchDetailScreenState();
}

class _MatchDetailScreenState extends ConsumerState<MatchDetailScreen> {
  late Future<MatchModel> matchDetailFuture;
  int? match_id;

  @override
  void initState() {
    super.initState();
    // match_id 초기화 및 Future 설정은 didChangeDependencies에서 수행
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final matchIdStr = RouteData.of(context).pathParameters['match_id'];
    if (matchIdStr != null) {
      match_id = int.tryParse(matchIdStr);
      if (match_id != null) {
        matchDetailFuture = ref
            .read(MatchControllerProvider.notifier)
            .getMatchDetail(match_id!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (match_id == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('매치 정보')),
        body: const Center(child: Text('Invalid match ID')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('매치 정보')),
      body: FutureBuilder<MatchModel>(
        future: matchDetailFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No match data available'));
          } else {
            final match = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(AppSpaceSize.largeSize),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
