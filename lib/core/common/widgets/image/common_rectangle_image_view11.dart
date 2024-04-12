import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../features/auth/models/secure_storage_model.dart';
import '../../../constants/constants.dart';
import '../../controllers/FileController.dart';

class CommonSquareImageView extends ConsumerWidget {
  final String profile_image;
  final double size;
  final String userName;

  const CommonSquareImageView({
    required this.profile_image,
    required this.size,
    required this.userName,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fileController = ref.read(fileControllerProvider.notifier);
    final storage = ref.read(secureStorageProvider); // storage 인스턴스 가져오기

    return profile_image.isNotEmpty
        ? FutureBuilder<String>(
            future: fileController.getImageUrl(profile_image),
            builder: (context, snapshot) {
              return FutureBuilder<dynamic>(
                future: storage.read(key: accessTokenKey), // 비동기적으로 토큰 읽기
                builder: (context, tokenSnapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      tokenSnapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData && snapshot.data != null) {
                      String? token = tokenSnapshot.data; // 토큰 사용
                      return Container(
                        width: size,
                        height: size,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                              snapshot.data!,
                              headers: token != null
                                  ? {'Authorization': 'Bearer $token'}
                                  : {},
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
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
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      // 텍스트를 중앙에 배치
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey, // 배경색 설정 (선택 사항)
      ),
      child: Text(
        userName.isNotEmpty ? userName[0] : '?',
        style: TextStyle(
          fontSize: size / 2, // 글자 크기를 size의 절반으로 설정
          color: Colors.white, // 글자 색상
        ),
      ),
    );
  }
}
