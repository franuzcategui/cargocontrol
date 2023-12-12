class OriginModel{
  final List<String> originNames;

  const OriginModel({
    required this.originNames,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is OriginModel &&
              runtimeType == other.runtimeType &&
              originNames == other.originNames);

  @override
  int get hashCode => originNames.hashCode;

  @override
  String toString() {
    return 'OriginModel{' + ' originNames: $originNames,' + '}';
  }

  OriginModel copyWith({
    List<String>? originNames,
  }) {
    return OriginModel(
      originNames: originNames ?? this.originNames,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'originNames': this.originNames,
    };
  }

  factory OriginModel.fromMap(Map<String, dynamic> map) {
    return OriginModel(
      originNames: (map['originNames'] as List<dynamic>).cast<String>(),
    );
  }

}