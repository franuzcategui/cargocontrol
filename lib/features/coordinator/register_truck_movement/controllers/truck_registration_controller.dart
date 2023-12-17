import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:cargocontrol/core/enums/viajes_status_enum.dart';
import 'package:cargocontrol/core/enums/viajes_type.dart';
import 'package:cargocontrol/features/coordinator/register_truck_movement/controllers/truck_registration_noti_controller.dart';
import 'package:cargocontrol/models/industry_models/industry_sub_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_model.dart';
import 'package:cargocontrol/models/viajes_models/viajes_model.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../commons/common_widgets/show_toast.dart';
import '../../../../models/vessel_models/vessel_cargo_model.dart';
import '../data/apis/truck_registration_apis.dart';

final truckRegistrationControllerProvider = StateNotifierProvider<TruckRegistrationController, bool>((ref) {
  final api = ref.watch(truckRegistrationApisProvider);
  return TruckRegistrationController(datasource:  api, );
});


final getPortEnteringViajesList = StreamProvider((ref) {
  final truckProvider = ref.watch(truckRegistrationControllerProvider.notifier);
  return truckProvider.getPortEnteringViajesList();
  }
);

final getPortLeavingViajesList = StreamProvider((ref) {
  final truckProvider = ref.watch(truckRegistrationControllerProvider.notifier);
  return truckProvider.getPortLeavingViajesList();
  }
);

final getAllViajesList = StreamProvider((ref) {
  final truckProvider = ref.watch(truckRegistrationControllerProvider.notifier);
  return truckProvider.getAllViajesList();
  }
);


class TruckRegistrationController extends StateNotifier<bool> {
  final TruckRegistrationApisImplements _datasource;

  TruckRegistrationController({required TruckRegistrationApisImplements datasource,})
      : _datasource = datasource,
        super(false);

  Future<void> registerTruckEnteringToPort({
    required double guideNumber,
    required String plateNumber,
    required double marchamo,
    required double emptyTruckWeight,
    required String vesselName,
    required String industryName,
    required String industryId,
    required String cargoId,
    required String choferesId,
    required String choferesname,
    required IndustrySubModel industrySubModel,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    state = true;

    final String viajesId = Uuid().v4();
    DateTime entryTimeToPort= DateTime.now();
    ViajesModel viajesModel = ViajesModel(
        entryTimeToPort: entryTimeToPort,
        entryTimeTruckWeightToPort: emptyTruckWeight,
        exitTimeToPort: DateTime.now(),
        exitTimeTruckWeightToPort: 0.0,
        uploadingTime: DateTime.now(),
        pureCargoWeight: 0.0,
        cargoUnloadWeight: 0.0,
        cargoDeficitWeight: 0.0,
        timeToIndustry: DateTime.now(),
        unloadingTimeInIndustry: DateTime.now(),
        guideNumber: guideNumber,
        industryId: industryId,
        chofereId: choferesId,
        chofereName: choferesname,
        licensePlate: plateNumber,
        cargoId: cargoId,
        viajesId: viajesId,
        viajesTypeEnum: ViajesTypeEnum.inProgress,
      viajesStatusEnum: ViajesStatusEnum.portEntered
    );

    IndustrySubModel industryModel = industrySubModel.copyWith(
      usedGuideNumbers: industrySubModel.usedGuideNumbers..add(guideNumber),
    );

    final result = await _datasource.registerTruckEnteringToPort(
        viajesModel: viajesModel,
      industrySubModel: industryModel
    );

    result.fold((l) {
      state = false;
      showSnackBar(context: context, content: l.message);
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message);
    }, (r) async{
      state = false;
      Navigator.pushNamed(context, AppRoutes.coRegistrationSuccessFullScreen);
      ref.read(truckRegistrationNotiControllerProvider).setIndustryMatchedStatus(false);
      ref.read(truckRegistrationNotiControllerProvider).setSelectedChofere(null);
      showSnackBar(context: context, content: 'Viajes Registered!');
      await ref.read(truckRegistrationNotiControllerProvider).getAllIndustriesModel();
    });
    state = false;
  }

  VesselModel updateCargoModel({required VesselModel originalModel, required VesselCargoModel updatedCargoModel}) {
    int cargoModelIndex = originalModel.cargoModels.indexWhere((cargoModel) => cargoModel.cargoId == updatedCargoModel.cargoId);
    if (cargoModelIndex != -1) {
      List<VesselCargoModel> updatedCargoModels = List.from(originalModel.cargoModels);
      updatedCargoModels[cargoModelIndex] = updatedCargoModel;
      return originalModel.copyWith(cargoModels: updatedCargoModels);
    } else {
      return originalModel;
    }
  }


  Future<void> registerTruckLeavingFromPort({
    required double pureCargoWeight,
    required double totalWeight,
    required ViajesModel viajesModel,
    required VesselModel vesselModel,
    required VesselCargoModel newCargoModel,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    state = true;

    DateTime exitTimeFromPort= DateTime.now();
    ViajesModel model = viajesModel.copyWith(
      exitTimeToPort: exitTimeFromPort,
      exitTimeTruckWeightToPort: totalWeight,
      pureCargoWeight: pureCargoWeight,
      viajesStatusEnum: ViajesStatusEnum.portLeft
    );

    VesselModel vessel = updateCargoModel(originalModel: vesselModel, updatedCargoModel: newCargoModel);

    final result = await _datasource.registerTruckLeavingFromPort(
        viajesModel: viajesModel,
        vesselModel: vessel
    );

    result.fold((l) {
      state = false;
      showSnackBar(context: context, content: l.message);
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message);
    }, (r) async{
      state = false;
      Navigator.pushNamed(context, AppRoutes.coRegistrationSuccessFullScreen);
      ref.read(truckRegistrationNotiControllerProvider).setIndustryMatchedStatus(false);
      ref.read(truckRegistrationNotiControllerProvider).setSelectedChofere(null);
      showSnackBar(context: context, content: 'Viajes Registered!');
      await ref.read(truckRegistrationNotiControllerProvider).getAllIndustriesModel();
    });
    state = false;
  }


  // Stream<IndustrySubModel> getCurrentIndusry() {
  //   return _datasource.getCurrentIndustry().
  //   map((event) {
  //     IndustrySubModel models = IndustrySubModel.fromMap(event.docs.first.data());
  //     return models;
  //   });
  // }


  Stream<List<ViajesModel>> getPortEnteringViajesList() {
    return _datasource.getPortEnteringViajesList().
    map((event) {
      List<ViajesModel> models = [];
      event.docs.forEach((element) {
        models.add(ViajesModel.fromMap(element.data()));
      });
      return models;
    });
  }


  Stream<List<ViajesModel>> getPortLeavingViajesList() {
    return _datasource.getPortLeavingViajesList().
    map((event) {
      List<ViajesModel> models = [];
      event.docs.forEach((element) {
        models.add(ViajesModel.fromMap(element.data()));
      });
      return models;
    });
  }

  Stream<List<ViajesModel>> getAllViajesList() {
    return _datasource.getAllViajesList().
    map((event) {
      List<ViajesModel> models = [];
      event.docs.forEach((element) {
        models.add(ViajesModel.fromMap(element.data()));
      });
      return models;
    });
  }


  Stream<List<ViajesModel>> getIndustryEnteringViajesList() {
    return _datasource.getIndustryEnteringViajesList().
    map((event) {
      List<ViajesModel> models = [];
      event.docs.forEach((element) {
        models.add(ViajesModel.fromMap(element.data()));
      });
      return models;
    });
  }

}
