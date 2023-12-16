import 'package:cargocontrol/models/viajes_models/viajes_model.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../commons/common_widgets/show_toast.dart';
import '../data/apis/truck_registration_apis.dart';

final viajesControllerProvider = StateNotifierProvider<TruckRegistrationController, bool>((ref) {
  final api = ref.watch(truckRegistrationApisProvider);
  return TruckRegistrationController(datasource:  api, );
});

final fetchCurrentIndustry = StreamProvider((ref) {
  final industryProvider = ref.watch(viajesControllerProvider.notifier);
  return industryProvider.getCurrentIndusry();
});


class TruckRegistrationController extends StateNotifier<bool> {
  final TruckRegistrationApisImplements _datasource;

  TruckRegistrationController({required TruckRegistrationApisImplements datasource,})
      : _datasource = datasource,
        super(false);

  Future<void> registerTruckEnteringToPort({
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

}
