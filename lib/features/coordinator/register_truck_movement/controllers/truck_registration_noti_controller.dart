import 'package:cargocontrol/commons/common_widgets/show_toast.dart';
import 'package:cargocontrol/features/admin/create_vessel/data/apis/ad_vessel_apis.dart';
import 'package:cargocontrol/models/industry_models/industry_sub_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_cargo_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_cargo_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_model.dart';
import 'package:cargocontrol/models/viajes_models/viajes_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/choferes_models/choferes_model.dart';
import '../../../../routes/route_manager.dart';
import '../data/apis/truck_registration_apis.dart';

final truckRegistrationNotiControllerProvider = ChangeNotifierProvider((ref){
  final api = ref.watch(truckRegistrationApisProvider);
  return TruckRegistrationNotiController(datasource: api);
});

class TruckRegistrationNotiController extends ChangeNotifier {
  final TruckRegistrationApisImplements _datasource;
  TruckRegistrationNotiController({required TruckRegistrationApisImplements datasource,})
      : _datasource = datasource,
        super();

  List<IndustrySubModel> _allIndustriesModels = [];
  List<IndustrySubModel> get allIndustriesModels => _allIndustriesModels;
  setAllIndustriesModels(List<IndustrySubModel> models) {
    _allIndustriesModels = models;
   notifyListeners();
  }

  Future getAllIndustriesModel() async{
   final result = await  _datasource.getAllIndustries(vesselId: vesselModel!.vesselId);
   result.fold((l) {
     debugPrintStack(stackTrace: l.stackTrace);
     debugPrint( l.message);
   }, (r) {
     print(r.length);
     setAllIndustriesModels(r);
   });
  }

  IndustrySubModel? _selectedIndustry;
  IndustrySubModel? get selectedIndustry => _selectedIndustry;
  setSelectedIndustry(IndustrySubModel? model){
    _selectedIndustry = model;
    notifyListeners();
  }


  getIndusytryFromGuideNumber({required double guideNumber})async{
    setLoading(true);

    if(allIndustriesModels.length != 0){
      for(int index =0; index< _allIndustriesModels.length; index++){
        print(_allIndustriesModels.length);
        print(index);
        if(
        guideNumber >= _allIndustriesModels[index].initialGuide &&
            guideNumber <= _allIndustriesModels[index].lastGuide &&
            vesselModel!.vesselId == _allIndustriesModels[index].vesselId &&
            !_allIndustriesModels[index].usedGuideNumbers.contains(guideNumber)
        ){
          print("usman1");

          _selectedIndustry = _allIndustriesModels[index];
          setIndustryMatchedStatus(true);
          break;
        }else{
          setIndustryMatchedStatus(false);
        }
      }
      setLoading(false);
    }else{
      await getAllIndustriesModel();
      for(int index =0; index< _allIndustriesModels.length; index++){
        if(
        guideNumber >= _allIndustriesModels[index].initialGuide &&
        guideNumber <= _allIndustriesModels[index].lastGuide &&
            vesselModel!.vesselId == _allIndustriesModels[index].vesselId &&
            !_allIndustriesModels[index].usedGuideNumbers.contains(guideNumber)
        ){
          print("usman");
          _selectedIndustry = _allIndustriesModels[index];
          setIndustryMatchedStatus(true);
          break;
        }else{
          setIndustryMatchedStatus(false);
        }
      }
      setLoading(false);
    }

    setLoading(false);
  }


  bool _isLoading = false;
  bool get isLoading=> _isLoading;
  setLoading(bool stat) {
    _isLoading = stat;
    notifyListeners();
  }

  bool _industryMatched = false;
  bool get industryMatched=> _industryMatched;
  setIndustryMatchedStatus(bool stat) {
    if(stat){
      _industryMatched = stat;
      notifyListeners();
    }else{
      _industryMatched = stat;
      _selectedIndustry = null;
      notifyListeners();
    }
  }



  ChoferesModel? _selectedChofere;
  ChoferesModel? get selectedChofere=> _selectedChofere;

  setSelectedChofere(ChoferesModel? snapshot) {
    _selectedChofere = snapshot;
    notifyListeners();
  }


  Future getMatchedViajes({
    required String plateNumber,
    required String vesselId,
    required BuildContext context,
    required WidgetRef ref,
  })async{
    _matchedViajes = null;
    setLoading(true);
    final result = await  _datasource.getMatchedViajes(plateNumber: plateNumber, vesselId: vesselId);
    result.fold((l) {
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint( l.message);
      showSnackBar(context: context, content: l.message);
      setLoading(false);
    }, (r) {
      _isLoading = false;
      setMatchedViajes(r);
      Navigator.pushNamed(context, AppRoutes.coTruckLeavingInformationScreen);
    });
  }

  ViajesModel? _matchedViajes;
  ViajesModel? get matchedViajes=> _matchedViajes;

  setMatchedViajes(ViajesModel? model) {
    _matchedViajes = model;
    notifyListeners();
  }

  IndustrySubModel? _viajesIndustry;
  IndustrySubModel? get viajesIndustry=> _viajesIndustry;

  setViajesIndustry() {
    _allIndustriesModels.forEach((element) {
      if(element.industryId == matchedViajes!.industryId){
        _viajesIndustry = element;
      }
    });
  }

  VesselCargoModel? _vesselCargoModel;
  VesselCargoModel? get vesselCargoModel=> _vesselCargoModel;

  VesselModel? _vesselModel;
  VesselModel? get vesselModel=> _vesselModel;

  getCurrentVesselToUpdate({required WidgetRef ref, required String cargoId})async{
    final result = await ref.read(adVesselApiProvider).getCurrentVessel();
    result.fold((l) {
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message);
    }, (r) {
      _vesselModel = r;
      r.cargoModels.forEach((cargo) {
        if(cargo.cargoId == cargoId){
          _vesselCargoModel = cargo;
        }
      });
      notifyListeners();
    }
    );
  }

  getCurrentVessel({required WidgetRef ref})async{
    final result = await ref.read(adVesselApiProvider).getCurrentVessel();
    result.fold((l) {
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message);
    }, (r) {
      _vesselModel = r;
      notifyListeners();
    }
    );
  }


}
