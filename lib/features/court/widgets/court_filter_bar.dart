import 'package:derbymatch/core/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/pallete.dart';

class CourtFilterBar extends ConsumerStatefulWidget {
  final VoidCallback loadCourts;

  const CourtFilterBar({required this.loadCourts, super.key});

  @override
  ConsumerState<CourtFilterBar> createState() => _CourtFilterBarState();
}

class _CourtFilterBarState extends ConsumerState<CourtFilterBar> {
  final TextEditingController _searchController = TextEditingController();

  void _onSearch() {
    // 여기에 검색 로직 추가
  }

  void _onFilter() {
    // 필터 로직을 여기에 추가
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpaceSize.mediumSize),
      height: 70, // 높이 설정
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '검색',
                prefixIcon: Icon(Icons.search),
                contentPadding:
                    EdgeInsets.symmetric(vertical: AppSpaceSize.mediumSize),
                // 패딩 조정
                border: OutlineInputBorder(
                  // 기본 테두리
                  borderSide: BorderSide(color: Pallete.primaryColor),
                  borderRadius: BorderRadius.all(
                      Radius.circular(AppSpaceSize.mediumSize)),
                ),
                enabledBorder: OutlineInputBorder(
                  // 활성화되지 않았을 때의 테두리
                  borderSide: BorderSide(color: Pallete.primaryColor),
                  borderRadius: BorderRadius.all(
                      Radius.circular(AppSpaceSize.mediumSize)),
                ),
                focusedBorder: OutlineInputBorder(
                  // 포커스 받았을 때의 테두리
                  borderSide: BorderSide(color: Pallete.primaryColor),
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppSpaceSize.mediumSize),
                  ),
                ),
              ),
              onFieldSubmitted: (_) => _onSearch(),
            ),
          ),
          IconButton(
            icon: Icon(Icons.filter_list_outlined),
            onPressed: _onFilter,
          ),
        ],
      ),
    );
  }
}
