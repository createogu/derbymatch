import 'dart:io';

import 'package:derbymatch/core/common/models/AttachFileModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../features/auth/models/secure_storage_model.dart';
import '../repositorys/FileRepository.dart';

final fileControllerProvider =
    StateNotifierProvider<FileStateNotifier, FileUploadState>((ref) {
  final fileRepository = ref.watch(fileRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);

  return FileStateNotifier(
    fileRepository: fileRepository,
    storage: storage,
    ref: ref,
  );
});

class FileStateNotifier extends StateNotifier<FileUploadState> {
  final FileRepository fileRepository;
  final FlutterSecureStorage storage;
  final Ref _ref;

  FileStateNotifier({
    required this.fileRepository,
    required this.storage,
    required Ref ref,
  })  : _ref = ref,
        super(FileUploadInitial()) {
    null;
  }

  Future<AttachFileModel> uploadSingleFile(List<File> files) async {
    try {
      // FileRepository에서 파일을 업로드하고 결과를 받음
      final AttachFileModel response =
          await fileRepository.uploadSingleFile(files);
      // 상태 업데이트 (업로드 성공)
      state = FileUploadSuccess(response);

      // 서버 응답 반환
      return response;
    } catch (e) {
      // 상태 업데이트 (업로드 실패)
      state = FileUploadFailure("업로드 중 에러: $e");

      // 예외 발생시, 해당 예외를 다시 던짐
      throw e;
    }
  }

  Future<String> getImageUrl(String fileName) async {
    try {
      // FileRepository에서 이미지 URL을 가져옴
      final String imageUrl = await fileRepository.getImageUrl(fileName);
      // 상태 업데이트 (URL 가져오기 성공)
      state = FileUploadSuccess(imageUrl);
      // 서버 응답 반환 (이미지 URL)
      return imageUrl;
    } catch (e) {
      // 상태 업데이트 (URL 가져오기 실패)
      state = FileUploadFailure("이미지 URL 가져오기 중 에러: $e");
      // 예외 발생시, 해당 예외를 다시 던짐
      throw e;
    }
  }
}

// 파일 업로드 상태를 나타내는 클래스
abstract class FileUploadState {}

class FileUploadInitial extends FileUploadState {}

class FileUploading extends FileUploadState {}

class FileUploadSuccess extends FileUploadState {
  final dynamic data;

  FileUploadSuccess(this.data);
}

class FileUploadFailure extends FileUploadState {
  final String message;

  FileUploadFailure(this.message);
}
