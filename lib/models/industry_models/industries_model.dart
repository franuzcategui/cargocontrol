class IndustriesModel{
  final String industryId;
  final String industryName;

//<editor-fold desc="Data Methods">
  const IndustriesModel({
    required this.industryId,
    required this.industryName,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IndustriesModel &&
          runtimeType == other.runtimeType &&
          industryId == other.industryId &&
          industryName == other.industryName);

  @override
  int get hashCode => industryId.hashCode ^ industryName.hashCode;

  @override
  String toString() {
    return 'IndustryModel{' +
        ' industryId: $industryId,' +
        ' industryName: $industryName,' +
        '}';
  }

  IndustriesModel copyWith({
    String? industryId,
    String? industryName,
  }) {
    return IndustriesModel(
      industryId: industryId ?? this.industryId,
      industryName: industryName ?? this.industryName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'industryId': this.industryId,
      'industryName': this.industryName,
    };
  }

  factory IndustriesModel.fromMap(Map<String, dynamic> map) {
    return IndustriesModel(
      industryId: map['industryId'] as String,
      industryName: map['industryName'] as String,
    );
  }

//</editor-fold>
}