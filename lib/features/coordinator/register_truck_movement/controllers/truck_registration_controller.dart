import 'package:cargocontrol/core/enums/viajes_status_enum.dart';
import 'package:cargocontrol/core/enums/viajes_type.dart';
import 'package:cargocontrol/models/viajes_models/viajes_model.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../commons/common_widgets/show_toast.dart';
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
    required String choferesId,
    required String choferesname,
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
        cargoId: '',
        viajesId: viajesId,
        viajesTypeEnum: ViajesTypeEnum.inProgress,
      viajesStatusEnum: ViajesStatusEnum.portEntered
    );

    final result = await _datasource.registerTruckEnteringToPort(
        viajesModel: viajesModel,
    );

    result.fold((l) {
      state = false;
      showSnackBar(context: context, content: l.message);
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message);
    }, (r) {
      state = false;
      Navigator.pushNamed(context, AppRoutes.coRegistrationSuccessFullScreen);
      showSnackBar(context: context, content: 'Viajes Registered!');
    });
    state = false;
  }

  Future<void> registerTruckLeavingFromPort({
    required ViajesModel viajesModel,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    state = true;
    final result = await _datasource.registerTruckEnteringToPort(viajesModel: viajesModel);

    result.fold((l) {
      state = false;
      showSnackBar(context: context, content: l.message);
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message);
    }, (r) {
      state = false;
      Navigator.pushNamed(context, AppRoutes.coRegistrationSuccessFullScreen);
      showSnackBar(context: context, content: 'Viajes Registered!');
    });
    state = false;
  }


  Stream<List<ViajesModel>> getCurrentIndusry() {
    return _datasource.getLAllViajesModels().
    map((event) {
      List<ViajesModel> models = [];
      event.docs.forEach((element) {
        models.add(ViajesModel.fromMap(event.docs.first.data()));
      });
      return models;
    });
  }


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
