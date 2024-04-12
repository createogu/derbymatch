class AddressModel {
  final String address_code;
  final String address_name;
  final String use_yn;

//<editor-fold desc="Data Methods">
  const AddressModel({
    required this.address_code,
    required this.address_name,
    required this.use_yn,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AddressModel &&
          runtimeType == other.runtimeType &&
          address_code == other.address_code &&
          address_name == other.address_name &&
          use_yn == other.use_yn);

  @override
  int get hashCode =>
      address_code.hashCode ^ address_name.hashCode ^ use_yn.hashCode;

  @override
  String toString() {
    return 'AddressModel{' +
        ' address_code: $address_code,' +
        ' address_name: $address_name,' +
        ' use_yn: $use_yn,' +
        '}';
  }

  AddressModel copyWith({
    String? address_code,
    String? address_name,
    String? use_yn,
  }) {
    return AddressModel(
      address_code: address_code ?? this.address_code,
      address_name: address_name ?? this.address_name,
      use_yn: use_yn ?? this.use_yn,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address_code': this.address_code,
      'address_name': this.address_name,
      'use_yn': this.use_yn,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      address_code: map['address_code'],
      address_name: map['address_name'],
      use_yn: map['use_yn'],
    );
  }

//</editor-fold>
}
