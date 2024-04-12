class CommCodeModel {
  final String comm_cd_type;
  final String comm_cd;
  final String comm_cd_nm;
  final String image_path;

//<editor-fold desc="Data Methods">
  const CommCodeModel({
    required this.comm_cd_type,
    required this.comm_cd,
    required this.comm_cd_nm,
    required this.image_path,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CommCodeModel &&
          runtimeType == other.runtimeType &&
          comm_cd_type == other.comm_cd_type &&
          comm_cd == other.comm_cd &&
          comm_cd_nm == other.comm_cd_nm &&
          image_path == other.image_path);

  @override
  int get hashCode =>
      comm_cd_type.hashCode ^
      comm_cd.hashCode ^
      comm_cd_nm.hashCode ^
      image_path.hashCode;

  @override
  String toString() {
    return 'CommCodeModel{' +
        ' comm_cd_type: $comm_cd_type,' +
        ' comm_cd: $comm_cd,' +
        ' comm_cd_nm: $comm_cd_nm,' +
        ' image_path: $image_path,' +
        '}';
  }

  CommCodeModel copyWith({
    String? comm_cd_type,
    String? comm_cd,
    String? comm_cd_nm,
    String? image_path,
  }) {
    return CommCodeModel(
      comm_cd_type: comm_cd_type ?? this.comm_cd_type,
      comm_cd: comm_cd ?? this.comm_cd,
      comm_cd_nm: comm_cd_nm ?? this.comm_cd_nm,
      image_path: image_path ?? this.image_path,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'comm_cd_type': this.comm_cd_type,
      'comm_cd': this.comm_cd,
      'comm_cd_nm': this.comm_cd_nm,
      'image_path': this.image_path,
    };
  }

  factory CommCodeModel.fromMap(Map<String, dynamic> map) {
    return CommCodeModel(
      comm_cd_type: map['comm_cd_type'] as String,
      comm_cd: map['comm_cd'] as String,
      comm_cd_nm: map['comm_cd_nm'] as String,
      image_path: map['image_path'] as String,
    );
  }

//</editor-fold>
}

class CommonCode {
  final Map<String, List<CommCodeModel>> codeCategories;

  const CommonCode({required this.codeCategories});

  List<CommCodeModel> getCodeListByType(String type) {
    return codeCategories[type] ?? [];
  }

  factory CommonCode.fromMap(List<dynamic> data) {
    Map<String, List<CommCodeModel>> codeMap = {};
    for (var item in data) {
      String commCdType = item['comm_cd_type'];
      CommCodeModel commCode = CommCodeModel.fromMap(item);

      if (!codeMap.containsKey(commCdType)) {
        codeMap[commCdType] = [];
      }
      codeMap[commCdType]!.add(commCode);
    }

    return CommonCode(codeCategories: codeMap);
  }
}
