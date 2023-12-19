import 'package:cargocontrol/commons/common_widgets/show_toast.dart';
import 'package:cargocontrol/models/industry_models/industry_sub_model.dart';
import 'package:cargocontrol/models/industry_models/industry_sub_model.dart';
import 'package:cargocontrol/models/industry_models/industry_sub_model.dart';
import 'package:cargocontrol/models/viajes_models/viajes_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../routes/route_manager.dart';
import '../../../coordinator/register_truck_movement/data/apis/truck_registration_apis.dart';

final inTruckRegistrationNotiControllerProvider = ChangeNotifierProvider((ref){
  final api = ref.watch(truckRegistrationApisProvider);
  return TruckRegistrationNotiController(datasource: api);
});

class TruckRegistrationNotiController extends ChangeNotifier {
  final TruckRegistrationApisImplements _datasource;
  TruckRegistrationNotiController({required TruckRegistrationApisImplements datasource,})
      : _datasource = datasource,
        super();

  bool _isLoading = false;
  bool get isLoading=> _isLoading;
  setLoading(bool stat) {
    _isLoading = stat;
    notifyListeners();
  }



  Future getMatchedViajesLinkedWithIndustry({
    required String plateNumber,
    required String industryId,
    required BuildContext context,
    required WidgetRef ref,
  })async{
    _matchedViajes = null;
    setLoading(true);
    final result = await  _datasource.getMatchedViajesLinkedWithIndustry(
      plateNumber: plateNumber,
      industryId: industryId
    );
    result.fold((l) {
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint( l.message);
      showSnackBar(context: context, content: l.message);
      setLoading(false);
    }, (r) {
      _isLoading = false;
      setMatchedViajes(r);
      Navigator.pushNamed(context, AppRoutes.inTruckArrivalInfoScreen);
    });
  }

  ViajesModel? _matchedViajes;
  ViajesModel? get matchedViajes=> _matchedViajes;

  setMatchedViajes(ViajesModel? model) {
    _matchedViajes = model;
    notifyListeners();
  }

  IndustrySubModel? _currentIndustryModel;
  IndustrySubModel? get currentIndustryModel=> _currentIndustryModel;
  setCurrentIndustry(IndustrySubModel? model) {
    _currentIndustryModel = model;
    notifyListeners();
  }

  Future getCurrentIndustry({
    required String realIndustryId,
    required BuildContext context,
    required WidgetRef ref,
  })async{
    _matchedViajes = null;
    setLoading(true);
    final result = await  _datasource.getIndustriaIndustrywithFuture(
      realIndustryId: realIndustryId
    );
    result.fold((l) {
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint( l.message);
      showSnackBar(context: context, content: l.message);
      setLoading(false);
    }, (r) {
      _isLoading = false;
      setCurrentIndustry(r);
    });
  }

}
