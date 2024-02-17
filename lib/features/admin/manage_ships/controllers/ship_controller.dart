import 'dart:async';

import 'package:cargocontrol/commons/common_functions/search_tags_handler.dart';
import 'package:cargocontrol/core/enums/choferes_status_enum.dart';
import 'package:cargocontrol/models/choferes_models/choferes_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../commons/common_widgets/show_toast.dart';
import '../data/apis/ship_apis.dart';
import 'ship_noti_controller.dart';

final shipControllerProvider = StateNotifierProvider<ShipController, bool>((ref) {
  final api = ref.watch(shipsApisProvider);
  return ShipController(datasource:  api, );
});


class ShipController extends StateNotifier<bool> {
  final ShipsApisImplements _datasource;

  ShipController({required ShipsApisImplements datasource,})
      : _datasource = datasource,
        super(false);




  Future<void> finishUnloadingVessel({
    required VesselModel vesselModel,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    state = true;
    VesselModel vesselModelUpdated= vesselModel.copyWith(
      exitDate: DateTime.now(),
      isFinishedUnloading: true,
    );
    final result = await _datasource.finishVesselUnloading(vesselModel: vesselModelUpdated);

    result.fold((l) {
      state = false;
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message);
      showSnackBar(context: context, content: l.message);
    }, (r) async{
      await _datasource.makeAllChoferesAvailable();
      await ref.read(shipNotiController).firstTime();
      state = false;
      showToast(msg: "Buque terminado de descargar!");
    });
    state = false;
  }




}
