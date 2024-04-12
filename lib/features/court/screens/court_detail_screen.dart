import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../../../core/values/values.dart';
import '../controllers/CourtController.dart';
import '../models/court_model.dart';

class CourtDetailScreen extends ConsumerStatefulWidget {
  const CourtDetailScreen({super.key});

  @override
  ConsumerState<CourtDetailScreen> createState() => _CourtDetailScreenState();
}

class _CourtDetailScreenState extends ConsumerState<CourtDetailScreen> {
  late Future<CourtModel> courtDetailFuture;
  int? court_id;

  @override
  void initState() {
    super.initState();
    // court_id 초기화 및 Future 설정은 didChangeDependencies에서 수행
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final courtIdStr = RouteData.of(context).pathParameters['court_id'];
    if (courtIdStr != null) {
      court_id = int.tryParse(courtIdStr);
      if (court_id != null) {
        courtDetailFuture = ref
            .read(CourtControllerProvider.notifier)
            .getCourtDetail(court_id!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (court_id == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('체육관 정보')),
        body: const Center(child: Text('Invalid court ID')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('체육관 정보')),
      body: FutureBuilder<CourtModel>(
        future: courtDetailFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No court data available'));
          } else {
            final court = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(AppSpaceSize.largeSize),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('코트명: ${court.court_name}',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: AppSpaceSize.mediumSize),
                    Text('코트 유형: ${court.court_type}'),
                    Text('코트 상세 유형: ${court.court_type_detail}'),
                    Text('도시 코드: ${court.city_code}'),
                    Text('구역 코드: ${court.district_code}'),
                    Text('우편번호: ${court.postal_code}'),
                    Text('도로명 주소: ${court.road_address}'),
                    Text('상세 주소: ${court.address_code}'),
                    Text('위도: ${court.latitude}'),
                    Text('경도: ${court.longitude}'),
                    Text('연락처: ${court.phone_number}'),
                    Text('주차 가능 여부: ${court.parking_available}'),
                    Text('시설 상태: ${court.facility_status}'),
                    Text('접근성 정보: ${court.accessibility_info ?? '정보 없음'}'),
                    Text('운영 시간: ${court.opening_hours ?? '정보 없음'}'),
                    Text('코트 설명: ${court.court_description ?? '정보 없음'}'),
                    Text('평점: ${court.rating.toString()}'),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
