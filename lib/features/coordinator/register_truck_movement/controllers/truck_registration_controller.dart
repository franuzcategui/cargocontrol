import 'package:cargocontrol/commons/common_imports/apis_commons.dart';
import 'package:cargocontrol/core/enums/choferes_status_enum.dart';
import 'package:cargocontrol/core/enums/viajes_status_enum.dart';
import 'package:cargocontrol/core/enums/viajes_type.dart';
import 'package:cargocontrol/features/coordinator/register_truck_movement/controllers/truck_registration_noti_controller.dart';
import 'package:cargocontrol/models/choferes_models/choferes_model.dart';
import 'package:cargocontrol/models/industry_models/industry_sub_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_model.dart';
import 'package:cargocontrol/models/viajes_models/viajes_model.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cargocontrol/utils/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../commons/common_widgets/show_toast.dart';
import '../../../../models/misc_models/industry_vessel_ids_model.dart';
import '../../../../models/vessel_models/vessel_cargo_model.dart';
import '../data/apis/truck_registration_apis.dart';

final truckRegistrationControllerProvider =
    StateNotifierProvider<TruckRegistrationController, bool>((ref) {
  final api = ref.watch(truckRegistrationApisProvider);
  return TruckRegistrationController(
    datasource: api,
  );
});

final getPortEnteringViajesList = StreamProvider.family((ref, String vesselId) {
  final truckProvider = ref.watch(truckRegistrationControllerProvider.notifier);
  return truckProvider.getPortEnteringViajesList(vesselId: vesselId);
});

final getAllInProgressViajesList =
    StreamProvider.family((ref, String industryId) {
  final truckProvider = ref.watch(truckRegistrationControllerProvider.notifier);
  return truckProvider.getAllInProgressViajesList(industryId: industryId);
});

final getAllCurrentVesselInProgressViajesList =
    StreamProvider.family((ref, String vesselId) {
  final truckProvider = ref.watch(truckRegistrationControllerProvider.notifier);
  return truckProvider.getAllCurrentVesselInProgressViajesList(
      vesselId: vesselId);
});
final getPortLeavingViajesList = StreamProvider.family((ref, String vesselId) {
  final truckProvider = ref.watch(truckRegistrationControllerProvider.notifier);
  return truckProvider.getPortLeavingViajesList(vesselId: vesselId);
});

final getAllViajesList = StreamProvider.family((ref, String vesselId) {
  final truckProvider = ref.watch(truckRegistrationControllerProvider.notifier);
  return truckProvider.getAllViajesList(vesselId: vesselId);
});

// Industria Section

final getIndustriaIndustry = StreamProvider.family(
    (ref, IndustryAndVesselIdsModel industryAndVesselIdsModel) {
  final truckProvider = ref.watch(truckRegistrationControllerProvider.notifier);
  return truckProvider.getIndustriaIndustry(
      industryAndVesselIdsModel: industryAndVesselIdsModel);
});

final getIndustriaIndustryByIndustryId =
    StreamProvider.family((ref, String industryId) {
  final truckProvider = ref.watch(truckRegistrationControllerProvider.notifier);
  return truckProvider.getIndustriaIndustryByIndustryId(industryId: industryId);
});

class TruckRegistrationController extends StateNotifier<bool> {
  final TruckRegistrationApisImplements _datasource;

  TruckRegistrationController({
    required TruckRegistrationApisImplements datasource,
  })  : _datasource = datasource,
        super(false);

  Future<void> registerTruckEnteringToPort({
    required double guideNumber,
    required String plateNumber,
    required double marchamo,
    required double emptyTruckWeight,
    required String vesselName,
    required String vesselId,
    required int vesselCargoHoldCount,
    required String industryName,
    required String industryId,
    required String cargoId,
    required String choferesId,
    required String choferesname,
    required String productName,
    required IndustrySubModel industrySubModel,
    required ChoferesModel choferesModel,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    state = true;

    final String viajesId = Uuid().v4();
    DateTime entryTimeToPort = DateTime.now();
    ViajesModel viajesModel = ViajesModel(
      entryTimeToPort: entryTimeToPort,
      entryTimeTruckWeightToPort: emptyTruckWeight,
      exitTimeToPort: AppConstants.constantDateTime,
      exitTimeTruckWeightToPort: 0.0,
      uploadingTime: AppConstants.constantDateTime,
      pureCargoWeight: 0.0,
      cargoUnloadWeight: 0.0,
      cargoDeficitWeight: 0.0,
      timeToIndustry: AppConstants.constantDateTime,
      unloadingTimeInIndustry: AppConstants.constantDateTime,
      guideNumber: guideNumber,
      industryId: industryId,
      chofereId: choferesId,
      chofereName: choferesname,
      licensePlate: plateNumber,
      cargoId: cargoId,
      productName: productName,
      viajesId: viajesId,
      viajesTypeEnum: ViajesTypeEnum.inProgress,
      viajesStatusEnum: ViajesStatusEnum.portEntered,
      industryName: industryName,
      vesselId: vesselId,
      vesselName: vesselName,
      cargoHoldCount: vesselCargoHoldCount,
    );
    ChoferesModel choferes = choferesModel.copyWith(
      choferesStatusEnum: ChoferesStatusEnum.portEntered,
      numberOfTrips: choferesModel.numberOfTrips + 1,
    );

    IndustrySubModel industryModel = industrySubModel.copyWith(
      usedGuideNumbers: industrySubModel.usedGuideNumbers..add(guideNumber),
    );

    final result = await _datasource.registerTruckEnteringToPort(
        viajesModel: viajesModel,
        industrySubModel: industryModel,
        choferesModel: choferes);

    result.fold((l) {
      state = false;
      showSnackBar(context: context, content: l.message);
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message);
    }, (r) async {
      state = false;
      await Navigator.pushNamed(
          context, AppRoutes.coRegistrationSuccessFullScreen);
      showToast(msg: 'Viajes Registered!');
    });
    state = false;
  }

  VesselModel updateCargoModel(
      {required VesselModel originalModel,
      required VesselCargoModel updatedCargoModel}) {
    int cargoModelIndex = originalModel.cargoModels.indexWhere(
        (cargoModel) => cargoModel.cargoId == updatedCargoModel.cargoId);
    if (cargoModelIndex != -1) {
      List<VesselCargoModel> updatedCargoModels =
          List.from(originalModel.cargoModels);
      updatedCargoModels[cargoModelIndex] = updatedCargoModel.copyWith(
          pesoUnloaded: updatedCargoModels[cargoModelIndex].pesoUnloaded +
              updatedCargoModel.pesoUnloaded);
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

    DateTime exitTimeFromPort = DateTime.now();
    ViajesModel model = viajesModel.copyWith(
        exitTimeToPort: exitTimeFromPort,
        exitTimeTruckWeightToPort: totalWeight,
        pureCargoWeight: pureCargoWeight,
        cargoHoldCount: vesselModel.numberOfCargos,
        viajesStatusEnum: ViajesStatusEnum.portLeft);
    VesselCargoModel vesselCargo =
        newCargoModel.copyWith(pesoUnloaded: pureCargoWeight);

    VesselModel vessel = updateCargoModel(
        originalModel: vesselModel, updatedCargoModel: vesselCargo);
    VesselModel vesselUpdate = vessel.copyWith(
        cargoUnloadedWeight: vessel.cargoUnloadedWeight - pureCargoWeight);

    final result = await _datasource.registerTruckLeavingFromPort(
        viajesModel: model, vesselModel: vesselUpdate);

    result.fold((l) {
      state = false;
      showSnackBar(context: context, content: l.message);
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message);
    }, (r) async {
      Navigator.pushNamed(context, AppRoutes.coRegistrationSuccessFullScreen);
      state = false;
      showSnackBar(context: context, content: 'Viajes Registered!');
    });
    state = false;
  }

  Stream<List<ViajesModel>> getPortEnteringViajesList(
      {required String vesselId}) {
    return _datasource
        .getPortEnteringViajesList(vesselId: vesselId)
        .map((event) {
      List<ViajesModel> models = [];
      event.docs.forEach((element) {
        models.add(ViajesModel.fromMap(element.data()));
      });
      return models;
    });
  }

  Stream<List<ViajesModel>> getAllInProgressViajesList(
      {required String industryId}) {
    return _datasource
        .getPortAllInProgressViajesList(industryId: industryId)
        .map((event) {
      List<ViajesModel> models = [];
      event.docs.forEach((element) {
        models.add(ViajesModel.fromMap(element.data()));
      });
      return models;
    });
  }

  Stream<List<ViajesModel>> getAllCurrentVesselInProgressViajesList(
      {required String vesselId}) {
    return _datasource
        .getAllCurrentVesselInProgressViajesList(vesselId: vesselId)
        .map((event) {
      List<ViajesModel> models = [];
      event.docs.forEach((element) {
        models.add(ViajesModel.fromMap(element.data()));
      });
      return models;
    });
  }

  Stream<List<ViajesModel>> getPortLeavingViajesList(
      {required String vesselId}) {
    return _datasource
        .getPortLeavingViajesList(vesselId: vesselId)
        .map((event) {
      List<ViajesModel> models = [];
      event.docs.forEach((element) {
        models.add(ViajesModel.fromMap(element.data()));
      });
      return models;
    });
  }

  Stream<List<ViajesModel>> getAllViajesList({required String vesselId}) {
    return _datasource.getAllViajesList(vesselId: vesselId).map((event) {
      List<ViajesModel> models = [];
      event.docs.forEach((element) {
        models.add(ViajesModel.fromMap(element.data()));
      });
      return models;
    });
  }

  Stream<List<ViajesModel>> getIndustryEnteringViajesList() {
    return _datasource.getIndustryEnteringViajesList().map((event) {
      List<ViajesModel> models = [];
      event.docs.forEach((element) {
        models.add(ViajesModel.fromMap(element.data()));
      });
      return models;
    });
  }

  // For Industria Section
  Stream<IndustrySubModel> getIndustriaIndustry(
      {required IndustryAndVesselIdsModel industryAndVesselIdsModel}) {
    return _datasource
        .getIndustriaIndustry(
            industryAndVesselIdsModel: industryAndVesselIdsModel)
        .map((event) {
      return IndustrySubModel.fromMap(event.docs.first.data());
    });
  }

  Stream<IndustrySubModel> getIndustriaIndustryByIndustryId(
      {required String industryId}) {
    return _datasource
        .getIndustriaIndustryByIndustryId(industryId: industryId)
        .map((event) {
      return IndustrySubModel.fromMap(event.docs.first.data());
    });
  }
}
