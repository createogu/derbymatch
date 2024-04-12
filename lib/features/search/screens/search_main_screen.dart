import 'package:derbymatch/core/theme/pallete.dart';
import 'package:derbymatch/core/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/widgets/selectAddress/widgets/search_address_bar_widget.dart';
import '../../auth/controllers/user_me_controller.dart';
import '../../auth/models/user_model.dart';
import '../../player/screens/player_main_screen.dart';
import '../../team/screens/team_list_screen.dart';

class SearchMainScreen extends ConsumerStatefulWidget {
  const SearchMainScreen({super.key});

  @override
  ConsumerState<SearchMainScreen> createState() => _SearchMainScreenState();
}

class _SearchMainScreenState extends ConsumerState<SearchMainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userMeProvider) as UserModel;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 200,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpaceSize.mediumSize),
          child: Text(
            '검색',
            style: AppTextStyles.titleTextStyle,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: AppSpaceSize.mediumSize),
                child: SearchAddressBar(user: user),
              ),
              TabBar(
                controller: _tabController,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                tabs: [
                  Tab(text: '선수'),
                  Tab(text: '팀'),
                  Tab(text: '체육관'),
                ],
                indicatorColor: Pallete.primaryColor,
                labelColor: Pallete.primaryColor,
                labelStyle: AppTextStyles.bodyTextStyle,
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          PlayerMainScreen(),
          TeamListScreen(),
        ],
      ),
    );
  }
}
