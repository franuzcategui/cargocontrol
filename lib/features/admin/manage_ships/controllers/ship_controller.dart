import 'dart:async';

import 'package:cargocontrol/commons/common_functions/search_tags_handler.dart';
import 'package:cargocontrol/core/enums/choferes_status_enum.dart';
import 'package:cargocontrol/models/choferes_models/choferes_model.dart';
import 'package:cargocontrol/models/industry_models/industry_sub_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_model.dart';
import 'package:cargocontrol/models/viajes_models/viajes_model.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../commons/common_widgets/show_toast.dart';
import '../data/apis/ship_apis.dart';
import 'ship_noti_controller.dart';

final shipControllerProvider =
    StateNotifierProvider<ShipController, bool>((ref) {
  final api = ref.watch(shipsApisProvider);
  return ShipController(
    datasource: api,
  );
});

class ShipController extends StateNotifier<bool> {
  final ShipsApisImplements _datasource;

  ShipController({
    required ShipsApisImplements datasource,
  })  : _datasource = datasource,
        super(false);

  Future<void> finishUnloadingVessel({
    required VesselModel vesselModel,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    state = true;
    VesselModel vesselModelUpdated = vesselModel.copyWith(
      exitDate: DateTime.now(),
      isFinishedUnloading: true,
    );
    final result = await _datasource.finishVesselUnloading(
        vesselModel: vesselModelUpdated);

    result.fold((l) {
      state = false;
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message);
      showSnackBar(context: context, content: l.message);
    }, (r) async {
      await _datasource.makeAllChoferesAvailable();
      await ref.read(shipNotiController).firstTime();
      state = false;
      showToast(msg: "Buque terminado de descargar!");
    });
    state = false;
  }

  Future<void> createReports({
    required VesselModel vesselModel,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    state = true;
    List<IndustrySubModel> allIndustryGuideModels = [];
    List<ViajesModel> allViajesModels = [];
    final getIndustrieesSubModels = await _datasource.getAllIndustrySubModels(
        vesselId: vesselModel.vesselId);

    getIndustrieesSubModels.fold((l) {
      state = false;
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message);
      showSnackBar(context: context, content: l.message);
      return;
    }, (r) async {
      allIndustryGuideModels = r;
    });

    final getAllViajeses =
        await _datasource.getAllViajes(vesselId: vesselModel.vesselId);

    getAllViajeses.fold((l) {
      state = false;
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message);
      showSnackBar(context: context, content: l.message);
      return;
    }, (r) async {
      allViajesModels = r;
    });
    state = false;
    if (allViajesModels.isNotEmpty && allIndustryGuideModels.isNotEmpty) {
      Navigator.pushNamed(context, AppRoutes.reportScreen, arguments: {
        'vesselModel': vesselModel,
        'allIndustriesModels': allIndustryGuideModels,
        'allViajesModel': allViajesModels
      });
    } else {
      showSnackBar(context: context, content: 'Unable to genearte report now!');
    }
  }

  Future<void> createReportsForIndustry({
    required VesselModel vesselModel,
    required WidgetRef ref,
    required BuildContext context,
    required String realIndustryId,
  }) async {
    state = true;
    List<IndustrySubModel> allIndustryGuideModels = [];
    List<ViajesModel> allViajesModels = [];
    final getIndustrieesSubModels = await _datasource.getAllIndustrySubModelsforIndustry(
        vesselId: vesselModel.vesselId, realIndustryId: realIndustryId);

    getIndustrieesSubModels.fold((l) {
      state = false;
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message);
      showSnackBar(context: context, content: l.message);
      return;
    }, (r) async {
      allIndustryGuideModels = r;
    });

    final getAllViajeses =
    await _datasource.getAllViajesForIndustry(vesselId: vesselModel.vesselId, realIndustryId: realIndustryId);

    getAllViajeses.fold((l) {
      state = false;
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message);
      showSnackBar(context: context, content: l.message);
      return;
    }, (r) async {
      allViajesModels = r;
    });
    state = false;
    if (allViajesModels.isNotEmpty && allIndustryGuideModels.isNotEmpty) {
      Navigator.pushNamed(context, AppRoutes.reportScreen, arguments: {
        'vesselModel': vesselModel,
        'allIndustriesModels': allIndustryGuideModels,
        'allViajesModel': allViajesModels
      });
    } else {
      showSnackBar(context: context, content: 'Unable to genearte report now!');
    }
  }
}
