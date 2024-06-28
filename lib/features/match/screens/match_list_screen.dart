import 'dart:async'; // Timer를 사용하기 위해 필요

import 'package:derbymatch/core/theme/pallete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/values/values.dart';
import '../../../core/common/widgets/tableCalendar/common_bar_calendar.dart';
import '../controllers/match_controller.dart';
import '../controllers/match_filter_controller.dart';
import '../models/match_model.dart';
import '../widgets/match_card.dart';
import '../widgets/match_filter_bottom_sheet.dart';

class MatchListScreen extends ConsumerStatefulWidget {
  const MatchListScreen({super.key});

  @override
  ConsumerState<MatchListScreen> createState() => _MatchMainScreenState();
}

class _MatchMainScreenState extends ConsumerState<MatchListScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<MatchModel> matchs = [];
  bool isLoading = false;
  bool isLastPage = false;
  late DateTime selectedMatchDate;
  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _loadMatchs();
    final matchFilterCommand = ref.read(matchFilterProvider);
    _scrollController.addListener(_scrollListener);
    selectedMatchDate = utils().stringToDate(matchFilterCommand.match_date);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !isLoading &&
        !isLastPage) {
      _loadMoreMatchs();
    }
  }

  Future<void> _loadMatchs() async {
    setState(() {
      isLoading = true;
      isLastPage = false;
    });

    final filterModel = ref.read(matchFilterProvider);

    try {
      final matchList = await ref
          .read(MatchControllerProvider.notifier)
          .getMatchList(filterModel);
      setState(() {
        matchs = matchList;
        isLoading = false;
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(0);
        }
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  Future<void> _loadMoreMatchs() async {
    final filterModel = ref.read(matchFilterProvider);
    ref.read(matchFilterProvider.notifier).setPage(filterModel.page + 1);

    setState(() => isLoading = true);

    try {
      final newMatchs = await ref
          .read(MatchControllerProvider.notifier)
          .getMatchList(ref.read(matchFilterProvider));
      setState(() {
        if (newMatchs.isEmpty) {
          isLastPage = true;
        } else {
          matchs.addAll(newMatchs);
        }
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        isLastPage = true;
        ref.read(matchFilterProvider.notifier).setPage(filterModel.page - 1);
      });
    }
  }

  void handleDaySelected(DateTime day) {
    ref.read(matchFilterProvider.notifier).setMatchDate(day);
    _loadMatchs();
    setState(() {
      selectedMatchDate = day; // 날짜 상태 업데이트
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.whiteColor,
      body: Container(
        child: Column(
          children: [
            Container(
              height: 140,
              child: CommonBarCalendar(
                focusedDay: selectedMatchDate,
                onDaySelected: handleDaySelected,
              ),
            ),
            Container(
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Chip(
                      label: Text(
                        '내 위치',
                        style: AppTextStyles.cautionTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AppSpacesBox.verticalSpaceMedium,
            Expanded(
              flex: 3,
              child: matchs.isEmpty && !isLoading
                  ? Center(child: Text('매치 목록이 없습니다.'))
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount: matchs.length + (isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < matchs.length) {
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: AppSpaceSize.smallSize),
                                child: MatchCard(match: matchs[index]),
                              ),
                              if (index < matchs.length - 1)
                                Divider(
                                  color: Pallete.greyColor.withOpacity(0.1),
                                ),
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
          ],
        ),
      ),
    );
  }

  void _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return MatchFilterBottomSheet(
          loadMatchs: _loadMatchs,
        );
      },
    );
  }
}
