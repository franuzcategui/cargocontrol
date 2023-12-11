import 'package:cargocontrol/models/vessel_models/origin_model.dart';
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

  getAllProducts()async{
   final result = await  _datasource.getAllProducts();
   result.fold((l) {
     debugPrintStack(stackTrace: l.stackTrace);
     debugPrint( l.message);
   }, (r) {
     print(r.length);
     setAllProducts(r);
   });
  }
}
