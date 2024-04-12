import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../features/auth/models/secure_storage_model.dart';
import '../../../constants/constants.dart';
import '../../controllers/FileController.dart';

class CommonCircleImageView extends ConsumerWidget {
  final String profileImage;
  final double radius;
  final String userName;

  const CommonCircleImageView({
    required this.profileImage,
    required this.radius,
    required this.userName,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fileController = ref.read(fileControllerProvider.notifier);
    final storage = ref.read(secureStorageProvider); // storage 인스턴스 가져오기

    return profileImage.isNotEmpty
        ? FutureBuilder<String>(
            future: fileController.getImageUrl(profileImage),
            builder: (context, snapshot) {
              return FutureBuilder<dynamic>(
                future: storage.read(key: accessTokenKey), // 비동기적으로 토큰 읽기
                builder: (context, tokenSnapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      tokenSnapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData && snapshot.data != null) {
                      String? token = tokenSnapshot.data; // 토큰 사용
                      return CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                          snapshot.data!,
                          headers: token != null
                              ? {'Authorization': 'Bearer $token'}
                              : {},
                        ),
                        radius: radius,
                      );
                    } else {
                      return _defaultAvatar();
                    }
                  } else if (snapshot.hasError || tokenSnapshot.hasError) {
                    return Text('이미지를 로드하는 데 실패했습니다.');
                  }
                  return CircularProgressIndicator(); // 로딩 인디케이터
                },
              );
            },
          )
        : _defaultAvatar();
  }

  Widget _defaultAvatar() {
    return CircleAvatar(
      radius: radius,
      child: Text(
        userName.isNotEmpty ? userName[0] : '?',
        style: TextStyle(fontSize: radius / 2),
      ),
    );
  }
}
