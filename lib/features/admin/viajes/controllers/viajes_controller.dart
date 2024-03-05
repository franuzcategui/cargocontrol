import 'dart:async';

import 'package:cargocontrol/commons/common_functions/search_tags_handler.dart';
import 'package:cargocontrol/core/enums/choferes_status_enum.dart';
import 'package:cargocontrol/features/admin/choferes/controllers/choferes_noti_controller.dart';
import 'package:cargocontrol/features/admin/viajes/controllers/viajes_completed_noti_controller.dart';
import 'package:cargocontrol/features/admin/viajes/controllers/viajes_inprogess_noti_controller.dart';
import 'package:cargocontrol/features/admin/viajes/controllers/viajes_noti_controller.dart';
import 'package:cargocontrol/models/choferes_models/choferes_model.dart';
import 'package:cargocontrol/models/industry_models/industry_sub_model.dart';
import 'package:cargocontrol/utils/thems/my_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../commons/common_widgets/show_toast.dart';
import '../../../../models/vessel_models/vessel_model.dart';
import '../../../../models/viajes_models/viajes_model.dart';
import '../data/apis/viajes_apis.dart';

final viajesControllerProvider = StateNotifierProvider<ViajesController, bool>((ref) {
  final api = ref.watch(viajesApisProvider);
  return ViajesController(datasource:  api, );
});

final getViajesModelFromViajesIdProvider = StreamProvider.family((ref,String viajesId) {
  final ctr = ref.watch(viajesControllerProvider .notifier);
  return ctr.getViajesModelFromViajesId(viajesId: viajesId);
});

class ViajesController extends StateNotifier<bool> {
  final ViajesApisImplements _datasource;

  ViajesController({required ViajesApisImplements datasource,})
      : _datasource = datasource,
        super(false);

  Future<void> updateVaijesModels({
    required ViajesModel viajesModel,
    required VesselModel vesselModel,
    required IndustrySubModel currentIndustryModel,
    required IndustrySubModel updatedIndustryModel,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    state = true;
    final result = await _datasource.updateViajesModels(viajesModel: viajesModel, vesselModel: vesselModel, currentIndustryModel: currentIndustryModel, updatedIndustryModel: updatedIndustryModel);

    result.fold((l) {
      state = false;
      showToast(msg:  l.message,textColor: MyColors.red);
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message);
    }, (r) async {
      state = false;
      showToast(msg: 'Viajes Updated!');
    });
    state = false;
  }

  Future<void> updateVaijesModelsForWeightUpdate({
    required ViajesModel viajesModel,
    required VesselModel vesselModel,
    required IndustrySubModel currentIndustryModel,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    state = true;
    final result = await _datasource.updateViajesModelsForWeight(viajesModel: viajesModel, vesselModel: vesselModel, currentIndustryModel: currentIndustryModel,);

    result.fold((l) {
      state = false;
      showToast(msg:  l.message,textColor: MyColors.red);
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message);
    }, (r) async {
      state = false;
      showToast(msg: 'Viajes Updated!');
    });
    state = false;
  }

  Stream<ViajesModel> getViajesModelFromViajesId({required String viajesId}) {
    return _datasource.getViajesModelFromViajesId(viajesId: viajesId);
  }

  Future<void> updateVaijestimings({
    required ViajesModel viajesModel,
    required DateTime portInTime,
    required DateTime portOutTime,
    required DateTime timeToIndustry,
    required DateTime unloadingTime,
    required WidgetRef ref,
  }) async {
    state = true;
    if(portInTime.isAfter(timeToIndustry) || portInTime.isAfter(unloadingTime) || portInTime.isAfter(portInTime)){
      state = false;
      showToast(msg: "La hora de llegada al puerto debe ser anterior a todos los horarios.",textColor: MyColors.red,long: true);
      return;
    }
    if(portOutTime.isAfter(timeToIndustry) || portOutTime.isAfter(unloadingTime) || portOutTime.isBefore(portInTime)){
      state = false;
      showToast(msg: "La hora de salida del puerto debe ser anterior a la hora de llegada y descarga de la industria",textColor: MyColors.red,long: true);
      return;
    }
    if(timeToIndustry.isBefore(portOutTime) || timeToIndustry.isAfter(unloadingTime) || timeToIndustry.isBefore(portInTime)){
      state = false;
      showToast(msg: "La hora de llegada de la industria debe ser posterior a la hora de salida del puerto y antes de la hora de descarga.",textColor: MyColors.red,long: true);
      return;
    }
    if(unloadingTime.isBefore(portOutTime) || unloadingTime.isBefore(timeToIndustry) || unloadingTime.isBefore(portInTime)){
      state = false;
      showToast(msg: "El tiempo de descarga debe ser posterior a la hora de salida del puerto y a la hora de llegada a la industria.",textColor: MyColors.red,long: true);
      return;
    }
    viajesModel= viajesModel.copyWith(
      timeToIndustry: timeToIndustry,
      unloadingTimeInIndustry: unloadingTime,
      entryTimeToPort: portInTime,
      exitTimeToPort: portOutTime,
    );
    final result = await _datasource.updateViajesModel(viajesModel: viajesModel);
    result.fold((l) {
      state = false;
      showToast(msg:  l.message,textColor: MyColors.red);
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message);
    }, (r) async {
      state = false;
      showToast(msg: 'Viajes Updated!');
    });
    state = false;
  }

  Future<void> updateVaijesModel({
    required ViajesModel viajesModel,
    required WidgetRef ref,
  }) async {
    state = true;
    final result = await _datasource.updateViajesModel(viajesModel: viajesModel);
    result.fold((l) {
      state = false;
      showToast(msg:  l.message,textColor: MyColors.red);
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message);
    }, (r) async {
      state = false;
      showToast(msg: 'Viajes Updated!');
    });
    state = false;
  }





}
