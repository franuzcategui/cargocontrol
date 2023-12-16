import 'package:cargocontrol/models/industry_models/industry_sub_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/apis/truck_registration_apis.dart';

final truckRegistrationNotiApiProvider = ChangeNotifierProvider((ref){
  final api = ref.watch(truckRegistrationApisProvider);
  return AdIndustryNotiController(datasource: api);
});

class AdIndustryNotiController extends ChangeNotifier {
  final TruckRegistrationApisImplements _datasource;
  AdIndustryNotiController({required TruckRegistrationApisImplements datasource,})
      : _datasource = datasource,
        super();

  List<IndustrySubModel> _allIndustriesModels = [];
  List<IndustrySubModel> get allIndustriesModels => _allIndustriesModels;
  setAllIndustriesModels(List<IndustrySubModel> models) {
    _allIndustriesModels = models;
   notifyListeners();
  }

  Future getAllIndustriesModel()async{
   final result = await  _datasource.getAllIndustries();
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
  getIndusytryFromGuideNumber({required double guideNumber})async{
    setLoading(true);
    if(allIndustriesModels.length!= 0){
      for(int index =0; index<= _allIndustriesModels.length; index++){
        if(guideNumber >= _allIndustriesModels[index].initialGuide && guideNumber <= _allIndustriesModels[index].lastGuide){
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
      for(int index =0; index<= _allIndustriesModels.length; index++){
        if(guideNumber >= _allIndustriesModels[index].initialGuide && guideNumber <= _allIndustriesModels[index].lastGuide){
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
    _industryMatched = stat;
    notifyListeners();
  }

}
