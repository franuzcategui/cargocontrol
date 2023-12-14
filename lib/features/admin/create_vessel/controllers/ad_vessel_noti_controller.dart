import 'package:cargocontrol/models/vessel_models/origin_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_cargo_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/vessel_models/product_model.dart';
import '../data/apis/ad_vessel_apis.dart';

final adVesselNotiController = ChangeNotifierProvider((ref){
  final adVesselApi = ref.watch(adVesselApiProvider);
  return AdVesselNotiController(datasource: adVesselApi);
});

class AdVesselNotiController extends ChangeNotifier {
  final AdVesselApisImplements _datasource;
  AdVesselNotiController({required AdVesselApisImplements datasource,})
      : _datasource = datasource,
        super();


  ProductModel? _productModel;
  ProductModel? get productModel => _productModel;
  setProductModel(ProductModel? model) {
    _productModel = model;
    notifyListeners();
  }

  OriginModel? _originModel;
  OriginModel? get originModel => _originModel;
  setOriginModel(OriginModel? model) {
    _originModel = model;
    notifyListeners();
  }

  List<ProductModel> _allProducts = [];
  List<ProductModel> get allProducts => _allProducts;
  setAllProducts(List<ProductModel> model) {
    _allProducts = model;
    // notifyListeners();
  }

  Future getAllProducts()async{
   final result = await  _datasource.getAllProducts();
   result.fold((l) {
     debugPrintStack(stackTrace: l.stackTrace);
     debugPrint( l.message);
   }, (r) {
     print(r.length);
     setAllProducts(r);
   });
  }

  Future getOrigins()async{
    final result = await  _datasource.getAllOrigins();
    result.fold((l) {
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint( l.message);
    }, (r) {
      setOriginModel(r);
    });
  }



  VesselModel? _vesselModel;
  VesselModel? get vesselModel => _vesselModel;
  setVesselModel(VesselModel? model) {
    _vesselModel = model;
    List<String> tempNames = [];
    _vesselModel?.cargoModels.forEach((cargoModel) {
      if(!tempNames.contains('${cargoModel.productName }, ${cargoModel.variety }, ${cargoModel.cosecha }, ${cargoModel.tipo } ')){
        tempNames.add('${cargoModel.productName }, ${cargoModel.variety }, ${cargoModel.cosecha }, ${cargoModel.tipo } ');
      }
    });
    setVesselProductNames(tempNames);
  }

  Future getCurrentVessel()async{
    final result = await  _datasource.getCurrentVessel();
    result.fold((l) {
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint( l.message);
    }, (r) {
      setVesselModel(r);
    });
  }

  List<String> _vesselProductNames = [];
  List<String> get vesselProductNames => _vesselProductNames;
  setVesselProductNames(List<String> names) {
    _vesselProductNames = names;
  }
  VesselCargoModel? _selectedVesselCargoModelForIndustry;
  VesselCargoModel? get selectedVesselCargoModelForIndustry => _selectedVesselCargoModelForIndustry;
  setVesselCargoModelForIndustry(VesselCargoModel? model) {
    _selectedVesselCargoModelForIndustry = model;
    notifyListeners();
  }

}
