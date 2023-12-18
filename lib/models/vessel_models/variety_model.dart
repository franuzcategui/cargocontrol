class VarietyModel{
  final List<String> varietyNames;

  const VarietyModel({
    required this.varietyNames,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is VarietyModel &&
              runtimeType == other.runtimeType &&
              varietyNames == other.varietyNames);

  @override
  int get hashCode => varietyNames.hashCode;

  @override
  String toString() {
    return 'VarietyModel{' + ' varietyNames: $varietyNames,' + '}';
  }

  VarietyModel copyWith({
    List<String>? varietyNames,
  }) {
    return VarietyModel(
      varietyNames: varietyNames ?? this.varietyNames,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'varietyNames': this.varietyNames,
    };
  }

  factory VarietyModel.fromMap(Map<String, dynamic> map) {
    return VarietyModel(
      varietyNames: map['varietyNames'] as List<String>,
    );
  }

}