class CosechaModel{
  final List<String> cosechaNames;

  const CosechaModel({
    required this.cosechaNames,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is CosechaModel &&
              runtimeType == other.runtimeType &&
              cosechaNames == other.cosechaNames);

  @override
  int get hashCode => cosechaNames.hashCode;

  @override
  String toString() {
    return 'CosechaModel{' + ' cosechaNames: $cosechaNames,' + '}';
  }

  CosechaModel copyWith({
    List<String>? cosechaNames,
  }) {
    return CosechaModel(
      cosechaNames: cosechaNames ?? this.cosechaNames,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cosechaNames': this.cosechaNames,
    };
  }

  factory CosechaModel.fromMap(Map<String, dynamic> map) {
    return CosechaModel(
      cosechaNames: map['cosechaNames'] as List<String>,
    );
  }

}