import 'package:cargocontrol/models/vessel_models/cosecha_model.dart';
import 'package:cargocontrol/models/vessel_models/origin_model.dart';
import 'package:cargocontrol/models/vessel_models/tipo_model.dart';
import 'package:cargocontrol/models/vessel_models/variety_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/vessel_models/product_model.dart';

final adMainMenuProvider = ChangeNotifierProvider((ref) => AdVesselNotiController());

class AdVesselNotiController extends ChangeNotifier {
  

  ProductModel? _productModel;
  ProductModel? get productModel => _productModel;
  setProductModel(ProductModel? model) {
    _productModel = model;
    notifyListeners();
  }

  VarietyModel? _varietyModel;
  VarietyModel? get varietyModel => _varietyModel;
  setVarietyModel(VarietyModel? model) {
    _varietyModel = model;
    notifyListeners();
  }


  OriginModel? _originModel;
  OriginModel? get originModel => _originModel;
  setOriginModel(OriginModel? model) {
    _originModel = model;
    notifyListeners();
  }


  CosechaModel? _cosechaModel;
  CosechaModel? get cosechaModel => _cosechaModel;
  setCosechaModel(CosechaModel? model) {
    _cosechaModel = model;
    notifyListeners();
  }

  TipoModel? _tipoModel;
  TipoModel? get tipoModel => _tipoModel;
  setTipoModel(TipoModel? model) {
    _tipoModel = model;
    notifyListeners();
  }
}
