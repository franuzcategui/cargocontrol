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
import '../data/apis/viajes_apis.dart';

final viajesUpdateNotiControllerProvider = ChangeNotifierProvider((ref){
  final api = ref.watch(viajesApisProvider);
  return ViajesUpdateNotiController(datasource: api);
});

class ViajesUpdateNotiController extends ChangeNotifier {
  final ViajesApisImplements _datasource;
  ViajesUpdateNotiController({required ViajesApisImplements datasource,})
      : _datasource = datasource,
        super();

  List<IndustrySubModel> _allIndustriesModels = [];
  List<IndustrySubModel> get allIndustriesModels => _allIndustriesModels;
  setAllIndustriesModels(List<IndustrySubModel> models) {
    _allIndustriesModels = models;
   notifyListeners();
  }

  Future getAllIndustriesModel()async{
   final result = await  _datasource.getAllIndustries(vesselId: vesselModel!.vesselId);
   result.fold((l) {
     debugPrintStack(stackTrace: l.stackTrace);
     debugPrint( l.message);
   }, (r) {
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
        if(
        guideNumber >= _allIndustriesModels[index].initialGuide &&
            guideNumber <= _allIndustriesModels[index].lastGuide &&
            vesselModel!.vesselId == _allIndustriesModels[index].vesselId &&
            !_allIndustriesModels[index].usedGuideNumbers.contains(guideNumber)
        ){
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


  VesselModel? _vesselModel;
  VesselModel? get vesselModel=> _vesselModel;


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

  IndustrySubModel? _currentIndustryModel;
  IndustrySubModel? get currentIndustryModel=> _currentIndustryModel;
  setCurrentIndustry(IndustrySubModel? model) {
    _currentIndustryModel = model;
    notifyListeners();
  }

  Future getCurrentIndustry({
    required String industryId,
    required WidgetRef ref,
  })async{
    setLoading(true);
    final result = await  _datasource.getIndustryGuideModel(industryId: industryId);
    result.fold((l) {
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint( l.message);
      setCurrentIndustry(null);
      setLoading(false);
    }, (r) {
      setLoading(false);
      setCurrentIndustry(r);
    });
  }


}
