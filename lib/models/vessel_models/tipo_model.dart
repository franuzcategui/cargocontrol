class TipoModel{
  final List<String> tipoNames;

  const TipoModel({
    required this.tipoNames,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is TipoModel &&
              runtimeType == other.runtimeType &&
              tipoNames == other.tipoNames);

  @override
  int get hashCode => tipoNames.hashCode;

  @override
  String toString() {
    return 'TipoModel{' + ' tipoNames: $tipoNames,' + '}';
  }

  TipoModel copyWith({
    List<String>? tipoNames,
  }) {
    return TipoModel(
      tipoNames: tipoNames ?? this.tipoNames,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tipoNames': this.tipoNames,
    };
  }

  factory TipoModel.fromMap(Map<String, dynamic> map) {
    return TipoModel(
      tipoNames: map['tipoNames'] as List<String>,
    );
  }

}