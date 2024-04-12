class AttachFileModel {
  final String uuid;
  final String file_name;
  final String upload_path;
  final String display_path;
  final bool image;

//<editor-fold desc="Data Methods">
  const AttachFileModel({
    required this.uuid,
    required this.file_name,
    required this.upload_path,
    required this.display_path,
    required this.image,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AttachFileModel &&
          runtimeType == other.runtimeType &&
          uuid == other.uuid &&
          file_name == other.file_name &&
          upload_path == other.upload_path &&
          display_path == other.display_path &&
          image == other.image);

  @override
  int get hashCode =>
      uuid.hashCode ^
      file_name.hashCode ^
      upload_path.hashCode ^
      display_path.hashCode ^
      image.hashCode;

  @override
  String toString() {
    return 'AttachFileModel{' +
        ' uuid: $uuid,' +
        ' file_name: $file_name,' +
        ' upload_path: $upload_path,' +
        ' display_path: $display_path,' +
        ' image: $image,' +
        '}';
  }

  AttachFileModel copyWith({
    String? uuid,
    String? file_name,
    String? upload_path,
    String? display_path,
    bool? image,
  }) {
    return AttachFileModel(
      uuid: uuid ?? this.uuid,
      file_name: file_name ?? this.file_name,
      upload_path: upload_path ?? this.upload_path,
      display_path: display_path ?? this.display_path,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uuid': this.uuid,
      'file_name': this.file_name,
      'upload_path': this.upload_path,
      'display_path': this.display_path,
      'image': this.image,
    };
  }

  factory AttachFileModel.fromMap(Map<String, dynamic> map) {
    return AttachFileModel(
      uuid: map['uuid'] as String,
      file_name: map['file_name'] as String,
      upload_path: map['upload_path'] as String,
      display_path: map['display_path'] as String,
      image: map['image'] as bool,
    );
  }

//</editor-fold>
}
