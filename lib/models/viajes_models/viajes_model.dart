import 'package:cargocontrol/core/enums/viajes_type.dart';

class ViajesModel{
  final String viajesId;
  final DateTime entryTimeToPort;
  final double entryTimeTruckWeightToPort;
  final DateTime exitTimeToPort;
  final double exitTimeTruckWeightToPort;
  final DateTime uploadingTime;
  final double pureCargoWeight;
  final double cargoUnloadWeight;
  final double cargoDeficitWeight;
  final DateTime timeToIndustry;
  final DateTime unloadingTimeInIndustry;
  final double guideNumber;
  final int industryId;
  final int chofereId;
  final String licensePlate;
  final String cargoId;
  final ViajesTypeEnum viajesTypeEnum;

//<editor-fold desc="Data Methods">
  const ViajesModel({
    required this.entryTimeToPort,
    required this.entryTimeTruckWeightToPort,
    required this.exitTimeToPort,
    required this.exitTimeTruckWeightToPort,
    required this.uploadingTime,
    required this.pureCargoWeight,
    required this.cargoUnloadWeight,
    required this.cargoDeficitWeight,
    required this.timeToIndustry,
    required this.unloadingTimeInIndustry,
    required this.guideNumber,
    required this.industryId,
    required this.chofereId,
    required this.licensePlate,
    required this.cargoId,
    required this.viajesId,
    required this.viajesTypeEnum,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ViajesModel &&
          runtimeType == other.runtimeType &&
          entryTimeToPort == other.entryTimeToPort &&
          entryTimeTruckWeightToPort == other.entryTimeTruckWeightToPort &&
          exitTimeToPort == other.exitTimeToPort &&
          exitTimeTruckWeightToPort == other.exitTimeTruckWeightToPort &&
          uploadingTime == other.uploadingTime &&
          pureCargoWeight == other.pureCargoWeight &&
          cargoUnloadWeight == other.cargoUnloadWeight &&
          cargoDeficitWeight == other.cargoDeficitWeight &&
          timeToIndustry == other.timeToIndustry &&
          unloadingTimeInIndustry == other.unloadingTimeInIndustry &&
          guideNumber == other.guideNumber &&
          industryId == other.industryId &&
          chofereId == other.chofereId &&
          licensePlate == other.licensePlate &&
          cargoId == other.cargoId &&
          viajesId == other.viajesId &&
          viajesTypeEnum == other.viajesTypeEnum);

  @override
  int get hashCode =>
      entryTimeToPort.hashCode ^
      entryTimeTruckWeightToPort.hashCode ^
      exitTimeToPort.hashCode ^
      exitTimeTruckWeightToPort.hashCode ^
      uploadingTime.hashCode ^
      pureCargoWeight.hashCode ^
      cargoUnloadWeight.hashCode ^
      cargoDeficitWeight.hashCode ^
      timeToIndustry.hashCode ^
      unloadingTimeInIndustry.hashCode ^
      guideNumber.hashCode ^
      industryId.hashCode ^
      chofereId.hashCode ^
      licensePlate.hashCode ^
      viajesId.hashCode ^
      cargoId.hashCode ^
      viajesTypeEnum.hashCode;

  @override
  String toString() {
    return 'ViajesModel{' +
        ' entryTimeToPort: $entryTimeToPort,' +
        ' entryTimeTruckWeightToPort: $entryTimeTruckWeightToPort,' +
        ' exitTimeToPort: $exitTimeToPort,' +
        ' exitTimeTruckWeightToPort: $exitTimeTruckWeightToPort,' +
        ' uploadingTime: $uploadingTime,' +
        ' pureCargoWeight: $pureCargoWeight,' +
        ' cargoUnloadWeight: $cargoUnloadWeight,' +
        ' cargoDeficitWeight: $cargoDeficitWeight,' +
        ' timeToIndustry: $timeToIndustry,' +
        ' unloadingTimeInIndustry: $unloadingTimeInIndustry,' +
        ' guideNumber: $guideNumber,' +
        ' industryId: $industryId,' +
        ' chofereId: $chofereId,' +
        ' licensePlate: $licensePlate,' +
        ' viajesId: $viajesId,' +
        ' cargoId: $cargoId,' +
        ' viajesTypeEnum: $viajesTypeEnum,' +
        '}';
  }

  ViajesModel copyWith({
    DateTime? entryTimeToPort,
    double? entryTimeTruckWeightToPort,
    DateTime? exitTimeToPort,
    double? exitTimeTruckWeightToPort,
    DateTime? uploadingTime,
    double? pureCargoWeight,
    double? cargoUnloadWeight,
    double? cargoDeficitWeight,
    DateTime? timeToIndustry,
    DateTime? unloadingTimeInIndustry,
    double? guideNumber,
    int? industryId,
    int? chofereId,
    String? licensePlate,
    String? cargoId,
    String? viajesId,
    ViajesTypeEnum? viajesTypeEnum,
  }) {
    return ViajesModel(
      entryTimeToPort: entryTimeToPort ?? this.entryTimeToPort,
      entryTimeTruckWeightToPort:
          entryTimeTruckWeightToPort ?? this.entryTimeTruckWeightToPort,
      exitTimeToPort: exitTimeToPort ?? this.exitTimeToPort,
      exitTimeTruckWeightToPort:
          exitTimeTruckWeightToPort ?? this.exitTimeTruckWeightToPort,
      uploadingTime: uploadingTime ?? this.uploadingTime,
      pureCargoWeight: pureCargoWeight ?? this.pureCargoWeight,
      cargoUnloadWeight: cargoUnloadWeight ?? this.cargoUnloadWeight,
      cargoDeficitWeight: cargoDeficitWeight ?? this.cargoDeficitWeight,
      timeToIndustry: timeToIndustry ?? this.timeToIndustry,
      unloadingTimeInIndustry:
          unloadingTimeInIndustry ?? this.unloadingTimeInIndustry,
      guideNumber: guideNumber ?? this.guideNumber,
      industryId: industryId ?? this.industryId,
      chofereId: chofereId ?? this.chofereId,
      licensePlate: licensePlate ?? this.licensePlate,
      cargoId: cargoId ?? this.cargoId,
      viajesId: viajesId ?? this.viajesId,
      viajesTypeEnum: viajesTypeEnum ?? this.viajesTypeEnum,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'entryTimeToPort': this.entryTimeToPort.millisecondsSinceEpoch,
      'exitTimeToPort': this.exitTimeToPort.millisecondsSinceEpoch,
      'uploadingTime': this.uploadingTime.millisecondsSinceEpoch,
      'timeToIndustry': this.timeToIndustry.millisecondsSinceEpoch,
      'unloadingTimeInIndustry': this.unloadingTimeInIndustry.millisecondsSinceEpoch,
      'pureCargoWeight': this.pureCargoWeight,
      'cargoUnloadWeight': this.cargoUnloadWeight,
      'exitTimeTruckWeightToPort': this.exitTimeTruckWeightToPort,
      'entryTimeTruckWeightToPort': this.entryTimeTruckWeightToPort,
      'cargoDeficitWeight': this.cargoDeficitWeight,
      'guideNumber': this.guideNumber,
      'industryId': this.industryId,
      'chofereId': this.chofereId,
      'licensePlate': this.licensePlate,
      'cargoId': this.cargoId,
      'viajesId': this.viajesId,
      'viajesTypeEnum': this.viajesTypeEnum.type,
    };
  }

  factory ViajesModel.fromMap(Map<String, dynamic> map) {
    return ViajesModel(
      entryTimeToPort: DateTime.fromMillisecondsSinceEpoch(map['entryTimeToPort']),
      exitTimeToPort: DateTime.fromMillisecondsSinceEpoch(map['exitTimeToPort']),
      timeToIndustry: DateTime.fromMillisecondsSinceEpoch(map['timeToIndustry']),
      unloadingTimeInIndustry: DateTime.fromMillisecondsSinceEpoch(map['unloadingTimeInIndustry']),
      uploadingTime: DateTime.fromMillisecondsSinceEpoch(map['uploadingTime']),
      entryTimeTruckWeightToPort: map['entryTimeTruckWeightToPort'] as double,
      exitTimeTruckWeightToPort: map['exitTimeTruckWeightToPort'] as double,
      pureCargoWeight: map['pureCargoWeight'] as double,
      cargoUnloadWeight: map['cargoUnloadWeight'] as double,
      cargoDeficitWeight: map['cargoDeficitWeight'] as double,
      guideNumber: map['guideNumber'] as double,
      industryId: map['industryId'] as int,
      chofereId: map['chofereId'] as int,
      licensePlate: map['licensePlate'] as String,
      cargoId: map['cargoId'] as String,
      viajesId: map['viajesId'] as String,
      viajesTypeEnum: (map['viajesTypeEnum'] as String).toViajesTypeEnum(),
    );
  }

//</editor-fold>
}