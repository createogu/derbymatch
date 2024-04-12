import 'package:derbymatch/core/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/values/values.dart';
import '../controllers/PlayerController.dart';
import '../controllers/PlayerFilterController.dart';
import '../models/player_model.dart';
import '../widgets/player_card.dart';
import '../widgets/player_filter_bottom_sheet.dart';

class PlayerListScreen extends ConsumerStatefulWidget {
  const PlayerListScreen({super.key});

  @override
  ConsumerState<PlayerListScreen> createState() => _PlayerMainScreenState();
}

class _PlayerMainScreenState extends ConsumerState<PlayerListScreen> {
  List<PlayerModel> players = [];
  bool isLoading = false;
  bool isLastPage = false; // 마지막 페이지인지 확인하는 변수
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadPlayers();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !isLoading &&
        !isLastPage) {
      _loadMorePlayers();
    }
  }

  Future<void> _loadPlayers() async {
    setState(() {
      isLoading = true;
      isLastPage = false; // 새로운 목록을 로드할 때마다 마지막 페이지 여부를 초기화
    });
    final filterModel = ref.read(playerFilterProvider);

    try {
      final playerList = await ref
          .read(PlayerControllerProvider.notifier)
          .getPlayerList(filterModel);
      setState(() {
        players = playerList;
        isLoading = false;
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(0); // 스크롤을 리스트의 최상단으로 이동
        }
      });
    } catch (e) {
      // 에러 처리
      setState(() => isLoading = false);
    }
  }

  Future<void> _loadMorePlayers() async {
    final filterModel = ref.read(playerFilterProvider);
    ref.read(playerFilterProvider.notifier).setPage(filterModel.page + 1);

    setState(() => isLoading = true);
    try {
      final newPlayers = await ref
          .read(PlayerControllerProvider.notifier)
          .getPlayerList(ref.read(playerFilterProvider));
      setState(() {
        if (newPlayers.isEmpty) {
          isLastPage = true; // 새로운 플레이어 목록이 비어있으면 마지막 페이지로 간주
        }
        players.addAll(newPlayers);
        isLoading = false;
      });
    } catch (e) {
      // 에러 처리
      setState(() {
        isLoading = false;
        isLastPage = true;
        ref.read(playerFilterProvider.notifier).setPage(filterModel.page - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.whiteColor,
      body: Padding(
        padding: EdgeInsets.all(AppSpaceSize.mediumSize),
        child: players.isEmpty && !isLoading
            ? Center(child: Text('선수 목록이 없습니다.'))
            : ListView.builder(
                controller: _scrollController,
                itemCount: players.length + (isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < players.length) {
                    return Column(
                      children: [
                        Container(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: AppSpaceSize.smallSize),
                          child: PlayerCard(player: players[index]),
                        ),
                        if (index < players.length - 1)
                          Divider(
                            color: Pallete.greyColor.withOpacity(0.1),
                          ),
                        // 마지막 아이템에는 Divider를 추가하지 않음
                      ],
                    );
                  } else {
                    return isLastPage
                        ? Container()
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                  }
                },
              ),
      ),
    );
  }

  void _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      scrollControlDisabledMaxHeightRatio: 0.8,
      context: context,
      builder: (BuildContext context) {
        return PlayerFilterBottomSheet(
          loadPlayers: _loadPlayers,
        );
      },
    );
  }
}
