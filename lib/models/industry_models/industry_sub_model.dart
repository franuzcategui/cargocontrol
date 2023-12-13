class IndustrySubModel{
  final String industryId;
  final String industryName;
  final String productName;
  final bool finishedUnloading;
  final double cargoAssigned;
  final double cargoUnloaded;
  final double initialGuide;
  final double lastGuide;

//<editor-fold desc="Data Methods">
  const IndustrySubModel({
    required this.industryId,
    required this.industryName,
    required this.productName,
    required this.finishedUnloading,
    required this.cargoAssigned,
    required this.cargoUnloaded,
    required this.initialGuide,
    required this.lastGuide,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IndustrySubModel &&
          runtimeType == other.runtimeType &&
          industryId == other.industryId &&
          industryName == other.industryName &&
          productName == other.productName &&
          finishedUnloading == other.finishedUnloading &&
          cargoAssigned == other.cargoAssigned &&
          cargoUnloaded == other.cargoUnloaded &&
          initialGuide == other.initialGuide &&
          lastGuide == other.lastGuide);

  @override
  int get hashCode =>
      industryId.hashCode ^
      industryName.hashCode ^
      productName.hashCode ^
      finishedUnloading.hashCode ^
      cargoAssigned.hashCode ^
      cargoUnloaded.hashCode ^
      initialGuide.hashCode ^
      lastGuide.hashCode;

  @override
  String toString() {
    return 'IndustrySubModel{' +
        ' industryId: $industryId,' +
        ' industryName: $industryName,' +
        ' productName: $productName,' +
        ' finishedUnloading: $finishedUnloading,' +
        ' cargoAssigned: $cargoAssigned,' +
        ' cargoUnloaded: $cargoUnloaded,' +
        ' initialGuide: $initialGuide,' +
        ' lastGuide: $lastGuide,' +
        '}';
  }

  IndustrySubModel copyWith({
    String? industryId,
    String? industryName,
    String? productName,
    bool? finishedUnloading,
    double? cargoAssigned,
    double? cargoUnloaded,
    double? initialGuide,
    double? lastGuide,
  }) {
    return IndustrySubModel(
      industryId: industryId ?? this.industryId,
      industryName: industryName ?? this.industryName,
      productName: productName ?? this.productName,
      finishedUnloading: finishedUnloading ?? this.finishedUnloading,
      cargoAssigned: cargoAssigned ?? this.cargoAssigned,
      cargoUnloaded: cargoUnloaded ?? this.cargoUnloaded,
      initialGuide: initialGuide ?? this.initialGuide,
      lastGuide: lastGuide ?? this.lastGuide,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'industryId': this.industryId,
      'industryName': this.industryName,
      'productName': this.productName,
      'finishedUnloading': this.finishedUnloading,
      'cargoAssigned': this.cargoAssigned,
      'cargoUnloaded': this.cargoUnloaded,
      'initialGuide': this.initialGuide,
      'lastGuide': this.lastGuide,
    };
  }

  factory IndustrySubModel.fromMap(Map<String, dynamic> map) {
    return IndustrySubModel(
      industryId: map['industryId'] as String,
      industryName: map['industryName'] as String,
      productName: map['productName'] as String,
      finishedUnloading: map['finishedUnloading'] as bool,
      cargoAssigned: map['cargoAssigned'] as double,
      cargoUnloaded: map['cargoUnloaded'] as double,
      initialGuide: map['initialGuide'] as double,
      lastGuide: map['lastGuide'] as double,
    );
  }

//</editor-fold>
}