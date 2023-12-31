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
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../commons/common_widgets/show_toast.dart';
import '../../../../models/vessel_models/vessel_cargo_model.dart';
import '../../../coordinator/register_truck_movement/data/apis/truck_registration_apis.dart';
import 'in_truck_registration_noti_controller.dart';

final inTruckRegistrationControllerProvider = StateNotifierProvider<TruckRegistrationController, bool>((ref) {
  final api = ref.watch(truckRegistrationApisProvider);
  return TruckRegistrationController(datasource:  api, );
});





final getChoferModelByNationalId= StreamProvider.family((ref, String nationalId) {
  final truckProvider = ref.watch(inTruckRegistrationControllerProvider.notifier);
  return truckProvider.getChoferModelByNationalId(nationalId: nationalId);
}
);

class TruckRegistrationController extends StateNotifier<bool> {
  final TruckRegistrationApisImplements _datasource;

  TruckRegistrationController({required TruckRegistrationApisImplements datasource,})
      : _datasource = datasource,
        super(false);


  Future<void> registerTruckEnteringInIndustry({
    required ViajesModel viajesModel,
    required IndustrySubModel industrySubModel,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    state = true;

    DateTime timeToIndustry= DateTime.now();
    ViajesModel model = viajesModel.copyWith(
      timeToIndustry: timeToIndustry,
      viajesStatusEnum: ViajesStatusEnum.industryEntered
    );

    IndustrySubModel industry = industrySubModel.copyWith(
      viajesIds: industrySubModel.viajesIds..add(viajesModel.viajesId),
    );

    final result = await _datasource.registerTruckEnteringInIndustry(
      viajesModel: model,
      industrySubModel: industry
    );

    result.fold((l) {
      state = false;
      showSnackBar(context: context, content: l.message);
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message);
    }, (r) async{
      state = false;
      Navigator.pushNamed(context, AppRoutes.inRegistrationSuccessFullScreen);
      showSnackBar(context: context, content: 'Viajes Registered!');
    });
    state = false;
  }


  Future<void> registerTruckUnloadingInIndustry({
    required double cargoUnloadWeight,
    required ViajesModel viajesModel,
    required IndustrySubModel industrySubModel,
    required ChoferesModel choferesModel,
    required VesselModel vesselModel,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    state = true;

    DateTime unloadingTimeInIndustry= DateTime.now();
    ViajesModel model = viajesModel.copyWith(
      cargoDeficitWeight: viajesModel.cargoDeficitWeight +viajesModel.exitTimeTruckWeightToPort - cargoUnloadWeight,
      cargoUnloadWeight: viajesModel.cargoUnloadWeight + cargoUnloadWeight,
      unloadingTimeInIndustry: unloadingTimeInIndustry,
      viajesTypeEnum: ViajesTypeEnum.completed,
      viajesStatusEnum: ViajesStatusEnum.industryUnloaded
    );

    IndustrySubModel industry = industrySubModel.copyWith(
      deficit: industrySubModel.deficit + (viajesModel.exitTimeTruckWeightToPort - cargoUnloadWeight),
      cargoUnloaded:industrySubModel.cargoUnloaded + cargoUnloadWeight - viajesModel.entryTimeTruckWeightToPort,
      selectedVesselCargo: industrySubModel.selectedVesselCargo.copyWith(
            pesoUnloaded: industrySubModel.selectedVesselCargo.pesoUnloaded + cargoUnloadWeight- viajesModel.entryTimeTruckWeightToPort,
          ),
    );
    double updatedChoferesDeficit=((choferesModel.averageCargoDeficit*(choferesModel.numberOfTrips-1) + (viajesModel.exitTimeTruckWeightToPort- cargoUnloadWeight))/choferesModel.numberOfTrips).ceilToDouble();
    ChoferesModel chofere  = choferesModel.copyWith(
      averageCargoDeficit: updatedChoferesDeficit,
      choferesStatusEnum: ChoferesStatusEnum.available
    );

    final result = await _datasource.registerTruckUnloadingInIndustry(
      viajesModel: model,
      industrySubModel: industry,
      choferesModel: chofere
    );

    result.fold((l) {
      state = false;
      showSnackBar(context: context, content: l.message);
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message);
    }, (r) async{
      state = false;
      Navigator.pushNamed(context, AppRoutes.inRegistrationSuccessFullScreen);
      showSnackBar(context: context, content: 'Viajes Unlaoded!');

    });
    state = false;
  }



  Stream<ChoferesModel> getChoferModelByNationalId({required String nationalId}) {
    return _datasource.getChoferModelByNationalId(nationalId: nationalId).
    map((event) {
      return ChoferesModel.fromMap(event.docs.first.data());
    });
  }


}
