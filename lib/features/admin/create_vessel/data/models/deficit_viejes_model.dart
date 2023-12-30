class DeficitViajesModel{
  final String viajesCount;
  final String totalDeficit;

//<editor-fold desc="Data Methods">
  const DeficitViajesModel({
    required this.viajesCount,
    required this.totalDeficit,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeficitViajesModel &&
          runtimeType == other.runtimeType &&
          viajesCount == other.viajesCount &&
          totalDeficit == other.totalDeficit);

  @override
  int get hashCode => viajesCount.hashCode ^ totalDeficit.hashCode;

  @override
  String toString() {
    return 'DeficitViajesModel{' +
        ' viajesCount: $viajesCount,' +
        ' totalDeficit: $totalDeficit,' +
        '}';
  }

  DeficitViajesModel copyWith({
    String? viajesCount,
    String? totalDeficit,
  }) {
    return DeficitViajesModel(
      viajesCount: viajesCount ?? this.viajesCount,
      totalDeficit: totalDeficit ?? this.totalDeficit,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'viajesCount': this.viajesCount,
      'totalDeficit': this.totalDeficit,
    };
  }

  factory DeficitViajesModel.fromMap(Map<String, dynamic> map) {
    return DeficitViajesModel(
      viajesCount: map['viajesCount'] as String,
      totalDeficit: map['totalDeficit'] as String,
    );
  }

//</editor-fold>
}