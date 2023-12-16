import '../vessel_models/vessel_cargo_model.dart';

class IndustrySubModel{
  final String industryId;
  final String industryName;
  final String vesselId;
  final String vesselName;
  final VesselCargoModel selectedVesselCargo;
  final bool finishedUnloading;
  final dynamic cargoAssigned;
  final dynamic cargoUnloaded;
  final dynamic initialGuide;
  final dynamic lastGuide;

//<editor-fold desc="Data Methods">
  const IndustrySubModel({
    required this.industryId,
    required this.industryName,
    required this.vesselName,
    required this.vesselId,
    required this.selectedVesselCargo,
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
          vesselId == other.vesselId &&
          vesselName == other.vesselName &&
          industryName == other.industryName &&
          selectedVesselCargo == other.selectedVesselCargo &&
          finishedUnloading == other.finishedUnloading &&
          cargoAssigned == other.cargoAssigned &&
          cargoUnloaded == other.cargoUnloaded &&
          initialGuide == other.initialGuide &&
          lastGuide == other.lastGuide);

  @override
  int get hashCode =>
      industryId.hashCode ^
      vesselId.hashCode ^
      industryName.hashCode ^
      vesselName.hashCode ^
      selectedVesselCargo.hashCode ^
      finishedUnloading.hashCode ^
      cargoAssigned.hashCode ^
      cargoUnloaded.hashCode ^
      initialGuide.hashCode ^
      lastGuide.hashCode;

  @override
  String toString() {
    return 'IndustrySubModel{' +
        ' industryId: $industryId,' +
        ' vesselId: $vesselId,' +
        ' vesselName: $vesselName,' +
        ' industryName: $industryName,' +
        ' selectedVesselCargo: $selectedVesselCargo,' +
        ' finishedUnloading: $finishedUnloading,' +
        ' cargoAssigned: $cargoAssigned,' +
        ' cargoUnloaded: $cargoUnloaded,' +
        ' initialGuide: $initialGuide,' +
        ' lastGuide: $lastGuide,' +
        '}';
  }

  IndustrySubModel copyWith({
    String? industryId,
    String? vesselId,
    String? industryName,
    String? vesselName,
    VesselCargoModel? selectedVesselCargo,
    bool? finishedUnloading,
    dynamic cargoAssigned,
    dynamic cargoUnloaded,
    dynamic initialGuide,
    dynamic lastGuide,
  }) {
    return IndustrySubModel(
      industryId: industryId ?? this.industryId,
      vesselId: vesselId ?? this.vesselId,
      industryName: industryName ?? this.industryName,
      vesselName: vesselName ?? this.vesselName,
      selectedVesselCargo: selectedVesselCargo ?? this.selectedVesselCargo,
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
      'vesselId': this.vesselId,
      'vesselName': this.vesselName,
      'selectedVesselCargo': this.selectedVesselCargo.toMap(),
      'finishedUnloading': this.finishedUnloading,
      'cargoAssigned': this.cargoAssigned,
      'cargoUnloaded': this.cargoUnloaded,
      'initialGuide': this.initialGuide,
      'lastGuide': this.lastGuide,
    };
  }

  factory IndustrySubModel.fromMap(Map<String, dynamic> map) {
    return IndustrySubModel(
      vesselId: map['vesselId'] as String,
      industryId: map['industryId'] as String,
      vesselName: map['vesselName'] as String,
      industryName: map['industryName'] as String,
      selectedVesselCargo: VesselCargoModel.fromMap(map['selectedVesselCargo'] as Map<String, dynamic>),
      finishedUnloading: map['finishedUnloading'] as bool,
      cargoAssigned: map['cargoAssigned'] as dynamic,
      cargoUnloaded: map['cargoUnloaded'] as dynamic,
      initialGuide: map['initialGuide'] as dynamic,
      lastGuide: map['lastGuide'] as dynamic,
    );
  }

//</editor-fold>
}