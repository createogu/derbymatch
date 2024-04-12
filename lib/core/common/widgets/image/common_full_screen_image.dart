import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../features/auth/models/secure_storage_model.dart';
import '../../../constants/constants.dart';
import '../../controllers/FileController.dart';

class CommonFullScreenImage extends ConsumerWidget {
  final String imagePath;

  CommonFullScreenImage({required this.imagePath});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fileController = ref.read(fileControllerProvider.notifier);
    final storage = ref.read(secureStorageProvider); // storage 인스턴스 가져오기

    return Scaffold(
      appBar: AppBar(),
      body: imagePath.isNotEmpty
          ? FutureBuilder<String>(
              future: fileController.getImageUrl(imagePath),
              builder: (context, snapshot) {
                return FutureBuilder<dynamic>(
                  future: storage.read(key: accessTokenKey), // 비동기적으로 토큰 읽기
                  builder: (context, tokenSnapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        tokenSnapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData && snapshot.data != null) {
                        String? token = tokenSnapshot.data; // 토큰 사용
                        return Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                snapshot.data!,
                                headers: token != null
                                    ? {'Authorization': 'Bearer $token'}
                                    : {},
                              ),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        );
                      } else {
                        return Center(
                          child: Text('이미지가 정상적이지 않습니다.'),
                        );
                      }
                    } else if (snapshot.hasError || tokenSnapshot.hasError) {
                      return Text('이미지를 로드하는 데 실패했습니다.');
                    }
                    return CircularProgressIndicator(); // 로딩 인디케이터
                  },
                );
              },
            )
          : Center(
              child: Text('이미지를 로드하는 데 실패했습니다.'),
            ),
    );
  }
}
