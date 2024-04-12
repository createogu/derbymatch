import 'dart:async'; // Timer를 사용하기 위해 필요

import 'package:derbymatch/core/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/values/values.dart';
import '../controllers/CourtController.dart';
import '../controllers/CourtFilterController.dart';
import '../models/court_model.dart';
import '../widgets/court_card.dart';
import '../widgets/court_filter_bottom_sheet.dart';

class CourtListScreen extends ConsumerStatefulWidget {
  const CourtListScreen({super.key});

  @override
  ConsumerState<CourtListScreen> createState() => _CourtMainScreenState();
}

class _CourtMainScreenState extends ConsumerState<CourtListScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<CourtModel> courts = [];
  bool isLoading = false;
  bool isLastPage = false;
  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _loadCourts();
    _scrollController.addListener(_scrollListener);
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
      _loadMoreCourts();
    }
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
      ref.read(courtFilterProvider.notifier).setCourtName(value);
      _loadCourts();
    });
  }

  Future<void> _loadCourts() async {
    setState(() {
      isLoading = true;
      isLastPage = false;
    });

    final filterModel = ref.read(courtFilterProvider);

    try {
      final courtList = await ref
          .read(CourtControllerProvider.notifier)
          .getCourtList(filterModel);
      setState(() {
        courts = courtList;
        isLoading = false;
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(0);
        }
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  Future<void> _loadMoreCourts() async {
    final filterModel = ref.read(courtFilterProvider);
    ref.read(courtFilterProvider.notifier).setPage(filterModel.page + 1);

    setState(() => isLoading = true);

    try {
      final newCourts = await ref
          .read(CourtControllerProvider.notifier)
          .getCourtList(ref.read(courtFilterProvider));
      setState(() {
        if (newCourts.isEmpty) {
          isLastPage = true;
        } else {
          courts.addAll(newCourts);
        }
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        isLastPage = true;
        ref.read(courtFilterProvider.notifier).setPage(filterModel.page - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.whiteColor,
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(AppSpaceSize.mediumSize),
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _searchController,
                      decoration: AppInputStyles.defaultInputStyle
                          .copyWith(hintText: '코트명으로 검색하세요.'),
                      onChanged: _onSearchChanged,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.filter_list_outlined),
                    onPressed: () {
                      _openBottomSheet(context);
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(AppSpaceSize.mediumSize),
                child: courts.isEmpty && !isLoading
                    ? Center(child: Text('체육관 목록이 없습니다.'))
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount: courts.length + (isLoading ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index < courts.length) {
                            return Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: AppSpaceSize.smallSize),
                                  child: CourtCard(court: courts[index]),
                                ),
                                if (index < courts.length - 1)
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
        return CourtFilterBottomSheet(
          loadCourts: _loadCourts,
        );
      },
    );
  }
}
