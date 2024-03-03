import 'dart:async';

import 'package:cargocontrol/commons/common_functions/search_tags_handler.dart';
import 'package:cargocontrol/core/enums/choferes_status_enum.dart';
import 'package:cargocontrol/features/admin/choferes/controllers/choferes_noti_controller.dart';
import 'package:cargocontrol/features/admin/viajes/controllers/viajes_completed_noti_controller.dart';
import 'package:cargocontrol/features/admin/viajes/controllers/viajes_inprogess_noti_controller.dart';
import 'package:cargocontrol/features/admin/viajes/controllers/viajes_noti_controller.dart';
import 'package:cargocontrol/models/choferes_models/choferes_model.dart';
import 'package:cargocontrol/models/industry_models/industry_sub_model.dart';
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
      showSnackBar(context: context, content: l.message);
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message);
    }, (r) async {
      // await ref.read(viajesNotiController).firstTime(ref: ref);
      // await ref.read(viajesInprogessNotiController).firstTime(ref: ref);
      // await ref.read(viajesCompletedNotiController).firstTime(ref: ref);
      state = false;
      showSnackBar(context: context, content: 'Viajes Updated!');
    });
    state = false;
  }



}
