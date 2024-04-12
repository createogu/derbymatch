import 'package:derbymatch/core/theme/pallete.dart';
import 'package:derbymatch/core/values/values.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BasketballMatch {
  final String team1;
  final String team2;
  final String matchTime;
  final String type; // '픽업게임' 또는 '게스트 모집'

  BasketballMatch(
      {required this.team1,
      required this.team2,
      required this.matchTime,
      required this.type});
}

class TodayQuickMatchList extends StatefulWidget {
  final List<BasketballMatch> matches;

  const TodayQuickMatchList({super.key, required this.matches});

  @override
  State<TodayQuickMatchList> createState() => _TodayQuickMatchListState();
}

class _TodayQuickMatchListState extends State<TodayQuickMatchList> {
  String selectedTab = '픽업게임'; // 초기 선택된 탭

  @override
  Widget build(BuildContext context) {
    List<BasketballMatch> filteredMatches =
        widget.matches.where((match) => match.type == selectedTab).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch, // 컬럼의 너비를 최대로 확장
      children: [
        Text("Today's QuickMatch", style: AppTextStyles.titleTextStyle),
        AppSpacesBox.verticalSpaceMedium,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // 픽업게임 탭
            ChoiceChip(
              label: Text(
                '픽업게임',
                style: AppTextStyles.infoTextStyle,
              ),
              selected: selectedTab == '픽업게임',
              onSelected: (bool selected) {
                setState(() {
                  selectedTab = '픽업게임';
                });
              },
              selectedColor: Pallete.primaryColor,
            ),
            AppSpacesBox.horizontalSpaceSmall,
            // 게스트 모집 탭
            ChoiceChip(
              label: Text(
                '게스트 모집',
                style: AppTextStyles.infoTextStyle,
              ),
              selected: selectedTab == '게스트 모집',
              onSelected: (bool selected) {
                setState(() {
                  selectedTab = '게스트 모집';
                });
              },
              selectedColor: Pallete.primaryColor,
            ),
          ],
        ),
        AppSpacesBox.verticalSpaceSmall,
        Expanded(
          child: CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
            ),
            items: filteredMatches.map((match) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(AppSpaceSize.largeSize),
                      child: Text(
                        'Match: ${match.team1} vs ${match.team2}\nTime: ${match.matchTime}',
                        style: AppTextStyles.bodyTextStyle,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
