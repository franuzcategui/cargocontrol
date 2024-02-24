class ChoferesTimeDeficitModel{
  final String choferesId;
  final String choferesName;
  final String realIndustryId;
  final String industryName;
  final Duration avgTimeDeficit;
  final Duration worstTimeDeficit;

//<editor-fold desc="Data Methods">
  const ChoferesTimeDeficitModel({
    required this.choferesId,
    required this.choferesName,
    required this.realIndustryId,
    required this.industryName,
    required this.avgTimeDeficit,
    required this.worstTimeDeficit,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChoferesTimeDeficitModel &&
          runtimeType == other.runtimeType &&
          choferesId == other.choferesId &&
          choferesName == other.choferesName &&
          realIndustryId == other.realIndustryId &&
          industryName == other.industryName &&
          avgTimeDeficit == other.avgTimeDeficit &&
          worstTimeDeficit == other.worstTimeDeficit);

  @override
  int get hashCode =>
      choferesId.hashCode ^
      choferesName.hashCode ^
      realIndustryId.hashCode ^
      industryName.hashCode ^
      avgTimeDeficit.hashCode ^
      worstTimeDeficit.hashCode;

  @override
  String toString() {
    return 'ChoferesTimeDeficitModel{' +
        ' choferesId: $choferesId,' +
        ' choferesName: $choferesName,' +
        ' realIndustryId: $realIndustryId,' +
        ' industryName: $industryName,' +
        ' avgTimeDeficit: $avgTimeDeficit,' +
        ' worstTimeDeficit: $worstTimeDeficit,' +
        '}';
  }

  ChoferesTimeDeficitModel copyWith({
    String? choferesId,
    String? choferesName,
    String? realIndustryId,
    String? industryName,
    Duration? avgTimeDeficit,
    Duration? worstTimeDeficit,
  }) {
    return ChoferesTimeDeficitModel(
      choferesId: choferesId ?? this.choferesId,
      choferesName: choferesName ?? this.choferesName,
      realIndustryId: realIndustryId ?? this.realIndustryId,
      industryName: industryName ?? this.industryName,
      avgTimeDeficit: avgTimeDeficit ?? this.avgTimeDeficit,
      worstTimeDeficit: worstTimeDeficit ?? this.worstTimeDeficit,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'choferesId': this.choferesId,
      'choferesName': this.choferesName,
      'realIndustryId': this.realIndustryId,
      'industryName': this.industryName,
      'avgTimeDeficit': this.avgTimeDeficit.inMilliseconds,
      'worstTimeDeficit': this.worstTimeDeficit.inMilliseconds,
    };
  }

  factory ChoferesTimeDeficitModel.fromMap(Map<String, dynamic> map) {
    return ChoferesTimeDeficitModel(
      choferesId: map['choferesId'] as String,
      choferesName: map['choferesName'] as String,
      realIndustryId: map['realIndustryId'] as String,
      industryName: map['industryName'] as String,
      avgTimeDeficit: Duration(milliseconds: map['avgTimeDeficit']),
      worstTimeDeficit: Duration(milliseconds: map['worstTimeDeficit']),
    );
  }

//</editor-fold>
}