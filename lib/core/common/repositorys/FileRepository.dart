import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';

import '../../constants/constants.dart';
import '../../dio/dio.dart';
import '../models/AttachFileModel.dart';

final fileRepositoryProvider = Provider<FileRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return FileRepository(dio, baseUrl: Constants.ip + '/common');
});

class FileRepository {
  final Dio _dio;
  final String? _baseUrl;

  FileRepository(this._dio, {String? baseUrl}) : _baseUrl = baseUrl;

  Future<List<AttachFileModel>> uploadMultiFile(List<File> files) async {
    List<MultipartFile> multipartFiles = [];

    for (File file in files) {
      MultipartFile multipartFile = await MultipartFile.fromFile(
        file.path,
        filename:
            basename(file.path), // 'package:path/path.dart'를 import 해야 사용 가능
      );
      multipartFiles.add(multipartFile);
    }

    FormData formData = FormData.fromMap({
      "uploadFile": multipartFiles,
    });

    try {
      final response = await _dio.post(
        '$_baseUrl/uploadMultiFile',
        data: formData,
        options: Options(headers: {'accessToken': 'true'}),
      );

      if (response.statusCode == 200) {
        List<dynamic> dataList = response.data;
        return dataList.map((data) => AttachFileModel.fromMap(data)).toList();
      } else {
        throw Exception('Failed to upload files');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<AttachFileModel> uploadSingleFile(List<File> files) async {
    List<MultipartFile> multipartFiles = [];

    for (File file in files) {
      MultipartFile multipartFile = await MultipartFile.fromFile(
        file.path,
        filename: basename(
            file.path), // 'package:path/path.dart'를 import 해야 basename 사용 가능
      );
      multipartFiles.add(multipartFile);
    }

    FormData formData = FormData.fromMap({
      "uploadFile": multipartFiles, // 서버의 파라미터 이름과 일치해야 함
    });

    try {
      final response = await _dio.post(
        '$_baseUrl/uploadSingleFile',
        data: formData,
        options: Options(headers: {'accessToken': 'true'}),
      );

      if (response.statusCode == 200) {
        return AttachFileModel.fromMap(response.data);
      } else {
        throw Exception('Failed to upload files');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getImageUrl(String fileName) async {
    try {
      final String imageUrl = '$_baseUrl/images/profile/' + fileName;
      // 서버로부터의 응답을 확인하기 위해 요청을 보내는 것이 좋습니다.
      final response = await _dio.get(
        imageUrl,
        options: Options(headers: {'accessToken': 'true'}),
      );
      if (response.statusCode == 200) {
        return imageUrl; // URL을 반환
      } else {
        throw Exception('Failed to upload files');
      }
    } catch (e) {
      rethrow;
    }
  }
}
