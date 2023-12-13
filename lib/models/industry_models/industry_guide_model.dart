import 'industry_sub_model.dart';

class IndustryGuideModel{
  final String vesselId;
  final String indusrtyGuideId;
  final List<IndustrySubModel> industrySubModels;

//<editor-fold desc="Data Methods">
  const IndustryGuideModel({
    required this.vesselId,
    required this.indusrtyGuideId,
    required this.industrySubModels,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IndustryGuideModel &&
          runtimeType == other.runtimeType &&
          vesselId == other.vesselId &&
          indusrtyGuideId == other.indusrtyGuideId &&
          industrySubModels == other.industrySubModels);

  @override
  int get hashCode => vesselId.hashCode ^ industrySubModels.hashCode;

  @override
  String toString() {
    return 'IndustryGuideModel{ vesselId: $vesselId, industrySubModels: $industrySubModels,}';
  }

  IndustryGuideModel copyWith({
    String? vesselId,
    String? indusrtyGuideId,
    List<IndustrySubModel>? industrySubModels,
  }) {
    return IndustryGuideModel(
      vesselId: vesselId ?? this.vesselId,
      indusrtyGuideId: indusrtyGuideId ?? this.indusrtyGuideId,
      industrySubModels: industrySubModels ?? this.industrySubModels,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'vesselId': this.vesselId,
      'indusrtyGuideId': this.indusrtyGuideId,
      'industrySubModels': this.industrySubModels.map((e) => e.toMap()).toList(),
    };
  }

  factory IndustryGuideModel.fromMap(Map<String, dynamic> map) {
    return IndustryGuideModel(
      vesselId: map['vesselId'] as String,
      indusrtyGuideId: map['indusrtyGuideId'] as String,
      industrySubModels: (map['industrySubModels'] as List<dynamic>).
      map((e) => IndustrySubModel.fromMap(e)).toList(),
    );
  }

//</editor-fold>
}