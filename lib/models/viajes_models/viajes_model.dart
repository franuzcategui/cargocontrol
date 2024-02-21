import 'package:cargocontrol/core/enums/viajes_status_enum.dart';
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
  final String industryId;
  final String industryName;
  final String realIndustryId;
  final String vesselId;
  final String vesselName;
  final String chofereId;
  final int cargoHoldCount;
  final String chofereName;
  final String productName;
  final String licensePlate;
  final String cargoId;
  final ViajesTypeEnum viajesTypeEnum;
  final ViajesStatusEnum viajesStatusEnum;

//<editor-fold desc="Data Methods">
  const ViajesModel({
    required this.viajesId,
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
    required this.industryName,
    required this.realIndustryId,
    required this.vesselId,
    required this.vesselName,
    required this.chofereId,
    required this.cargoHoldCount,
    required this.chofereName,
    required this.productName,
    required this.licensePlate,
    required this.cargoId,
    required this.viajesTypeEnum,
    required this.viajesStatusEnum,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ViajesModel &&
          runtimeType == other.runtimeType &&
          viajesId == other.viajesId &&
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
          industryName == other.industryName &&
          realIndustryId == other.realIndustryId &&
          vesselId == other.vesselId &&
          vesselName == other.vesselName &&
          chofereId == other.chofereId &&
          cargoHoldCount == other.cargoHoldCount &&
          chofereName == other.chofereName &&
          productName == other.productName &&
          licensePlate == other.licensePlate &&
          cargoId == other.cargoId &&
          viajesTypeEnum == other.viajesTypeEnum &&
          viajesStatusEnum == other.viajesStatusEnum);

  @override
  int get hashCode =>
      viajesId.hashCode ^
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
      industryName.hashCode ^
      realIndustryId.hashCode ^
      vesselId.hashCode ^
      vesselName.hashCode ^
      chofereId.hashCode ^
      cargoHoldCount.hashCode ^
      chofereName.hashCode ^
      productName.hashCode ^
      licensePlate.hashCode ^
      cargoId.hashCode ^
      viajesTypeEnum.hashCode ^
      viajesStatusEnum.hashCode;

  @override
  String toString() {
    return 'ViajesModel{' +
        ' viajesId: $viajesId,' +
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
        ' industryName: $industryName,' +
        ' realIndustryId: $realIndustryId,' +
        ' vesselId: $vesselId,' +
        ' vesselName: $vesselName,' +
        ' chofereId: $chofereId,' +
        ' cargoHoldCount: $cargoHoldCount,' +
        ' chofereName: $chofereName,' +
        ' productName: $productName,' +
        ' licensePlate: $licensePlate,' +
        ' cargoId: $cargoId,' +
        ' viajesTypeEnum: $viajesTypeEnum,' +
        ' viajesStatusEnum: $viajesStatusEnum,' +
        '}';
  }

  ViajesModel copyWith({
    String? viajesId,
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
    String? industryId,
    String? industryName,
    String? realIndustryId,
    String? vesselId,
    String? vesselName,
    String? chofereId,
    int? cargoHoldCount,
    String? chofereName,
    String? productName,
    String? licensePlate,
    String? cargoId,
    ViajesTypeEnum? viajesTypeEnum,
    ViajesStatusEnum? viajesStatusEnum,
  }) {
    return ViajesModel(
      viajesId: viajesId ?? this.viajesId,
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
      industryName: industryName ?? this.industryName,
      realIndustryId: realIndustryId ?? this.realIndustryId,
      vesselId: vesselId ?? this.vesselId,
      vesselName: vesselName ?? this.vesselName,
      chofereId: chofereId ?? this.chofereId,
      cargoHoldCount: cargoHoldCount ?? this.cargoHoldCount,
      chofereName: chofereName ?? this.chofereName,
      productName: productName ?? this.productName,
      licensePlate: licensePlate ?? this.licensePlate,
      cargoId: cargoId ?? this.cargoId,
      viajesTypeEnum: viajesTypeEnum ?? this.viajesTypeEnum,
      viajesStatusEnum: viajesStatusEnum ?? this.viajesStatusEnum,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'viajesId': this.viajesId,
      'entryTimeToPort': this.entryTimeToPort.millisecondsSinceEpoch,
      'entryTimeTruckWeightToPort': this.entryTimeTruckWeightToPort,
      'exitTimeToPort': this.exitTimeToPort.millisecondsSinceEpoch,
      'exitTimeTruckWeightToPort': this.exitTimeTruckWeightToPort,
      'uploadingTime': this.uploadingTime.millisecondsSinceEpoch,
      'pureCargoWeight': this.pureCargoWeight,
      'cargoUnloadWeight': this.cargoUnloadWeight,
      'cargoDeficitWeight': this.cargoDeficitWeight,
      'timeToIndustry': this.timeToIndustry.millisecondsSinceEpoch,
      'unloadingTimeInIndustry': this.unloadingTimeInIndustry.millisecondsSinceEpoch,
      'guideNumber': this.guideNumber,
      'industryId': this.industryId,
      'industryName': this.industryName,
      'realIndustryId': this.realIndustryId,
      'vesselId': this.vesselId,
      'vesselName': this.vesselName,
      'chofereId': this.chofereId,
      'cargoHoldCount': this.cargoHoldCount,
      'chofereName': this.chofereName,
      'productName': this.productName,
      'licensePlate': this.licensePlate,
      'cargoId': this.cargoId,
      'viajesTypeEnum': this.viajesTypeEnum.type,
      'viajesStatusEnum': this.viajesStatusEnum.type,
    };
  }

  factory ViajesModel.fromMap(Map<String, dynamic> map) {
    return ViajesModel(
      entryTimeToPort: DateTime.fromMillisecondsSinceEpoch(map['entryTimeToPort']),
      exitTimeToPort: DateTime.fromMillisecondsSinceEpoch(map['exitTimeToPort']),
      timeToIndustry: DateTime.fromMillisecondsSinceEpoch(map['timeToIndustry']),
      unloadingTimeInIndustry: DateTime.fromMillisecondsSinceEpoch(map['unloadingTimeInIndustry']),
      uploadingTime: DateTime.fromMillisecondsSinceEpoch(map['uploadingTime']),
      pureCargoWeight: map['pureCargoWeight'] as double,
      cargoUnloadWeight: map['cargoUnloadWeight'] as double,
      cargoDeficitWeight: map['cargoDeficitWeight'] as double,
      guideNumber: map['guideNumber'] as double,
      industryId: map['industryId'] as String,
      industryName: map['industryName'] as String,
      realIndustryId: map['realIndustryId'] as String,
      vesselId: map['vesselId'] as String,
      vesselName: map['vesselName'] as String,
      chofereId: map['chofereId'] as String,
      cargoHoldCount: map['cargoHoldCount'] as int,
      chofereName: map['chofereName'] as String,
      productName: map['productName'] as String,
      licensePlate: map['licensePlate'] as String,
      cargoId: map['cargoId'] as String,
      viajesTypeEnum: (map['viajesTypeEnum'] as String).toViajesTypeEnum(),
      viajesStatusEnum: (map['viajesStatusEnum'] as String).toViajesStatusEnum(),
      viajesId: map['viajesId'] as String,
      entryTimeTruckWeightToPort: map['entryTimeTruckWeightToPort'] as double,
      exitTimeTruckWeightToPort: map['exitTimeTruckWeightToPort'] as double,
    );
  }



//</editor-fold>
}

/*

  Map<String, dynamic> toMap() {
    return {
      'viajesId': this.viajesId,
      'entryTimeToPort': this.entryTimeToPort.millisecondsSinceEpoch,
      'entryTimeTruckWeightToPort': this.entryTimeTruckWeightToPort,
      'exitTimeToPort': this.exitTimeToPort.millisecondsSinceEpoch,
      'exitTimeTruckWeightToPort': this.exitTimeTruckWeightToPort,
      'uploadingTime': this.uploadingTime.millisecondsSinceEpoch,
      'pureCargoWeight': this.pureCargoWeight,
      'cargoUnloadWeight': this.cargoUnloadWeight,
      'cargoDeficitWeight': this.cargoDeficitWeight,
      'timeToIndustry': this.timeToIndustry.millisecondsSinceEpoch,
      'unloadingTimeInIndustry': this.unloadingTimeInIndustry.millisecondsSinceEpoch,
      'guideNumber': this.guideNumber,
      'industryId': this.industryId,
      'industryName': this.industryName,
      'vesselId': this.vesselId,
      'vesselName': this.vesselName,
      'chofereId': this.chofereId,
      'cargoHoldCount': this.cargoHoldCount,
      'chofereName': this.chofereName,
      'productName': this.productName,
      'licensePlate': this.licensePlate,
      'cargoId': this.cargoId,
      'viajesTypeEnum': this.viajesTypeEnum.type,
      'viajesStatusEnum': this.viajesStatusEnum.type,
    };
  }

  factory ViajesModel.fromMap(Map<String, dynamic> map) {
    return ViajesModel(
      entryTimeToPort: DateTime.fromMillisecondsSinceEpoch(map['entryTimeToPort']),
      exitTimeToPort: DateTime.fromMillisecondsSinceEpoch(map['exitTimeToPort']),
      timeToIndustry: DateTime.fromMillisecondsSinceEpoch(map['timeToIndustry']),
      unloadingTimeInIndustry: DateTime.fromMillisecondsSinceEpoch(map['unloadingTimeInIndustry']),
      uploadingTime: DateTime.fromMillisecondsSinceEpoch(map['uploadingTime']),
      pureCargoWeight: map['pureCargoWeight'] as double,
      cargoUnloadWeight: map['cargoUnloadWeight'] as double,
      cargoDeficitWeight: map['cargoDeficitWeight'] as double,
      guideNumber: map['guideNumber'] as double,
      industryId: map['industryId'] as String,
      industryName: map['industryName'] as String,
      vesselId: map['vesselId'] as String,
      vesselName: map['vesselName'] as String,
      chofereId: map['chofereId'] as String,
      cargoHoldCount: map['cargoHoldCount'] as int,
      chofereName: map['chofereName'] as String,
      productName: map['productName'] as String,
      licensePlate: map['licensePlate'] as String,
      cargoId: map['cargoId'] as String,
      viajesTypeEnum: (map['viajesTypeEnum'] as String).toViajesTypeEnum(),
      viajesStatusEnum: (map['viajesStatusEnum'] as String).toViajesStatusEnum(),
      viajesId: map['viajesId'] as String,
      entryTimeTruckWeightToPort: map['entryTimeTruckWeightToPort'] as double,
      exitTimeTruckWeightToPort: map['exitTimeTruckWeightToPort'] as double,
    );
  }

*/