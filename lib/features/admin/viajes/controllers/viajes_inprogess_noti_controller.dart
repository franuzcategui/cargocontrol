import 'dart:async';

import 'package:cargocontrol/models/industry_models/industries_model.dart';
import 'package:cargocontrol/models/viajes_models/viajes_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/choferes_models/choferes_model.dart';
import '../../create_vessel/controllers/ad_vessel_controller.dart';
import '../data/apis/viajes_apis.dart';

final viajesInprogessNotiController = ChangeNotifierProvider((ref) {
  final api = ref.watch(viajesApisProvider);
  return ViajesInprogessNotiController(datasource: api);
});

class ViajesInprogessNotiController extends ChangeNotifier {
  final ViajesApisImplements _datasource;
  ViajesInprogessNotiController({
    required ViajesApisImplements datasource,
  })  : _datasource = datasource,
        super();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  setLoading(bool stat) {
    _isLoading = stat;
    notifyListeners();
  }

  bool _isSecondaryLoading = false;
  bool get isSecondaryLoading => _isSecondaryLoading;
  setSecondaryLoading(bool stat) {
    _isSecondaryLoading = stat;
    notifyListeners();
  }

  List<ViajesModel> _viajesModels = [];
  List<ViajesModel> get viajesModels => _viajesModels;
  setViajesModels(List<ViajesModel> models) {
    _viajesModels = models;
    notifyListeners();
  }

  DocumentSnapshot? _lastSnapshot;
  DocumentSnapshot? get lastSnapshot => _lastSnapshot;

  setLastSnapShot(DocumentSnapshot? snapshot) {
    _lastSnapshot = snapshot;
    notifyListeners();
  }

  int _limit = 10;
  int get limit => _limit;

  setLimit({required int snapshot, required bool hasMoreData}) {
    _limit = snapshot;
    notifyListeners();
  }

  Future getInprogessViajes({required WidgetRef ref}) async {
    setSecondaryLoading(true);
    String vesselId= await ref.read(adVesselProvider.notifier).getCurrentVesselId();

    QuerySnapshot querySnapshot = await _datasource.getInprogressViajes(
      limit: limit,
      snapshot: _lastSnapshot,
      vesselId: vesselId
    );

    List<ViajesModel> models = [];
    for (var document in querySnapshot.docs) {
      var model =
          ViajesModel.fromMap(document.data() as Map<String, dynamic>);
      _viajesModels.add(model);
    }

    if (querySnapshot.docs.isNotEmpty) {
      _lastSnapshot = querySnapshot.docs.last;
      _limit = _limit + 10;
    }
    setSecondaryLoading(false);
    return models;
  }

  Future firstTime({required WidgetRef ref}) async {
    _limit = 10;
    _lastSnapshot = null;
    _viajesModels = [];

    _isLoading = true;
    notifyListeners();


    String vesselId= await ref.read(adVesselProvider.notifier).getCurrentVesselId();

    QuerySnapshot querySnapshot =
        await _datasource.getInprogressViajes(limit: limit, snapshot: _lastSnapshot,vesselId: vesselId);

    List<ViajesModel> models = [];
    for (var document in querySnapshot.docs) {
      var model =
          ViajesModel.fromMap(document.data() as Map<String, dynamic>);
      models.add(model);
    }
    _viajesModels = models;
    if (querySnapshot.docs.isNotEmpty) {
      _lastSnapshot = querySnapshot.docs.last;
      _limit = _limit + 10;
    }
    _isLoading = false;
    notifyListeners();

  }
}
