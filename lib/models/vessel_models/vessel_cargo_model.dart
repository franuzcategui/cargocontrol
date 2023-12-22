class VesselCargoModel{
  final String cargoId;
  final String productName;
  final String tipo;
  final String origen;
  final String variety;
  final String cosecha;
  final dynamic pesoTotal;
  final dynamic pesoUnloaded;

//<editor-fold desc="Data Methods">
  const VesselCargoModel({
    required this.cargoId,
    required this.productName,
    required this.tipo,
    required this.origen,
    required this.variety,
    required this.cosecha,
    required this.pesoTotal,
    required this.pesoUnloaded,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VesselCargoModel &&
          runtimeType == other.runtimeType &&
          cargoId == other.cargoId &&
          productName == other.productName &&
          tipo == other.tipo &&
          origen == other.origen &&
          variety == other.variety &&
          cosecha == other.cosecha &&
          pesoTotal == other.pesoTotal &&
          pesoUnloaded == other.pesoUnloaded
      );

  @override
  int get hashCode =>
      cargoId.hashCode ^
      productName.hashCode ^
      tipo.hashCode ^
      origen.hashCode ^
      variety.hashCode ^
      cosecha.hashCode ^
      pesoTotal.hashCode ^
      pesoUnloaded.hashCode
  ;

  @override
  String toString() {
    return 'VesselCargoModel{' +
        ' cargoId: $cargoId,' +
        ' productName: $productName,' +
        ' tipo: $tipo,' +
        ' origen: $origen,' +
        ' variety: $variety,' +
        ' cosecha: $cosecha,' +
        ' pesoTotal: $pesoTotal,' +
        ' pesoUnloaded: $pesoUnloaded,' +
        '}';
  }

  VesselCargoModel copyWith({
    String? cargoId,
    String? productName,
    String? tipo,
    String? origen,
    String? variety,
    String? cosecha,
    dynamic pesoTotal,
    dynamic pesoUnloaded,
  }) {
    return VesselCargoModel(
      cargoId: cargoId ?? this.cargoId,
      productName: productName ?? this.productName,
      tipo: tipo ?? this.tipo,
      origen: origen ?? this.origen,
      variety: variety ?? this.variety,
      cosecha: cosecha ?? this.cosecha,
      pesoTotal: pesoTotal ?? this.pesoTotal,
      pesoUnloaded: pesoUnloaded ?? this.pesoUnloaded,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cargoId': this.cargoId,
      'productName': this.productName,
      'tipo': this.tipo,
      'origen': this.origen,
      'variety': this.variety,
      'cosecha': this.cosecha,
      'pesoTotal': this.pesoTotal,
      'pesoUnloaded': this.pesoUnloaded,
    };
  }

  factory VesselCargoModel.fromMap(Map<String, dynamic> map) {
    return VesselCargoModel(
      cargoId: map['cargoId'] as String,
      productName: map['productName'] as String,
      tipo: map['tipo'] as String,
      origen: map['origen'] as String,
      variety: map['variety'] as String,
      cosecha: map['cosecha'] as String,
      pesoTotal: map['pesoTotal'] as dynamic,
      pesoUnloaded: map['pesoUnloaded'] as dynamic,
    );
  }

//</editor-fold>
}