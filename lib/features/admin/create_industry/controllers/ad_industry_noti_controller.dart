import 'package:cargocontrol/models/industry_models/industries_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/apis/ad_industry_apis.dart';

final adIndustryNotiController = ChangeNotifierProvider((ref){
  final adIndustryApi = ref.watch(adIndustryApiProvider);
  return AdIndustryNotiController(datasource: adIndustryApi);
});

class AdIndustryNotiController extends ChangeNotifier {
  final AdIndustryApisImplements _datasource;
  AdIndustryNotiController({required AdIndustryApisImplements datasource,})
      : _datasource = datasource,
        super();

  List<IndustriesModel> _allIndustriesModels = [];
  List<IndustriesModel> get allIndustriesModels => _allIndustriesModels;
  setAllIndustriesModels(List<IndustriesModel> models) {
    _allIndustriesModels = models;
    List<String> tempNames = [];
    _allIndustriesModels.forEach((industryModel) {
      tempNames.add(industryModel.industryName);
    });
    setIndustryNames(tempNames);
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

  List<String> _industryNames = [];
  List<String> get industryNames => _industryNames;
  setIndustryNames(List<String> names) {
    _industryNames = names;
  }

}
