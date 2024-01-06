class IndustryAndVesselIdsModel{
  final String industryId;
  final String vesselId;

//<editor-fold desc="Data Methods">
  const IndustryAndVesselIdsModel({
    required this.industryId,
    required this.vesselId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IndustryAndVesselIdsModel &&
          runtimeType == other.runtimeType &&
          industryId == other.industryId &&
          vesselId == other.vesselId);

  @override
  int get hashCode => industryId.hashCode ^ vesselId.hashCode;

  @override
  String toString() {
    return 'IndustryAndVesselIdsModel{' +
        ' industryId: $industryId,' +
        ' vesselId: $vesselId,' +
        '}';
  }

  IndustryAndVesselIdsModel copyWith({
    String? industryId,
    String? vesselId,
  }) {
    return IndustryAndVesselIdsModel(
      industryId: industryId ?? this.industryId,
      vesselId: vesselId ?? this.vesselId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'industryId': this.industryId,
      'vesselId': this.vesselId,
    };
  }

  factory IndustryAndVesselIdsModel.fromMap(Map<String, dynamic> map) {
    return IndustryAndVesselIdsModel(
      industryId: map['industryId'] as String,
      vesselId: map['vesselId'] as String,
    );
  }

//</editor-fold>
}