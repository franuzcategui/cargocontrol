import 'package:cargocontrol/commons/common_widgets/show_toast.dart';
import 'package:cargocontrol/models/choferes_models/choferes_model.dart';
import 'package:cargocontrol/models/choferes_models/choferes_model.dart';
import 'package:cargocontrol/models/choferes_models/choferes_model.dart';
import 'package:cargocontrol/models/industry_models/industry_sub_model.dart';
import 'package:cargocontrol/models/industry_models/industry_sub_model.dart';
import 'package:cargocontrol/models/industry_models/industry_sub_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_cargo_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_cargo_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_cargo_model.dart';
import 'package:cargocontrol/models/viajes_models/viajes_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/enums/viajes_status_enum.dart';
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
    required String pageName,
    required ViajesStatusEnum viajesStatusEnum,
    required BuildContext context,
    required WidgetRef ref,
  })async{
    _matchedViajes = null;
    setLoading(true);
    final result = await  _datasource.getMatchedViajesLinkedWithIndustry(
      plateNumber: plateNumber,
      industryId: industryId,
      viajesStatusEnum: viajesStatusEnum
    );
    result.fold((l) {
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint( l.message);
      showSnackBar(context: context, content: l.message);
      setLoading(false);
    }, (r) {
      _isLoading = false;
      setMatchedViajes(r);
      Navigator.pushNamed(context, pageName);
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

  Future getViajesCargo({
    required String vesselId,
    required String cargoId,
    required BuildContext context,
    required WidgetRef ref,
  })async{
    setLoading(true);
    final result = await  _datasource.getVesselCargoModel(
        vesselId: vesselId
    );
    result.fold((l) {
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint( l.message);
      showSnackBar(context: context, content: l.message);
      setLoading(false);
    }, (r) {
      _isLoading = false;
      r.cargoModels.forEach((cargo) {
        if(cargo.cargoId == cargoId){
          setViajesCargoModel(cargo);
        }
      });
    });
  }

  VesselCargoModel? _vesselCargoModel;
  VesselCargoModel? get vesselCargoModel=> _vesselCargoModel;

  setViajesCargoModel(VesselCargoModel? model) {
    _vesselCargoModel = model;
    notifyListeners();
  }


  Future getChoferesModel({
    required String nationalIdNumber,
    required BuildContext context,
    required WidgetRef ref,
  })async{
    setLoading(true);
    final result = await  _datasource.getChoferesForViajes(
       nationalId: nationalIdNumber
    );
    result.fold((l) {
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint( l.message);
      showSnackBar(context: context, content: l.message);
      setLoading(false);
    }, (r) {
      _isLoading = false;
      setViajesChoferesModel(r);
    });
  }


  ChoferesModel? _viajesChoferesModel;
  ChoferesModel? get viajesChoferesModel=> _viajesChoferesModel;

  setViajesChoferesModel(ChoferesModel? model) {
    _viajesChoferesModel = model;
    notifyListeners();
  }

}
