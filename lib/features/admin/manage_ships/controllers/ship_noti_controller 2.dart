import 'dart:async';

import 'package:cargocontrol/models/industry_models/industries_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/apis/ship_apis.dart';

final shipNotiController = ChangeNotifierProvider((ref){
  final api = ref.watch(shipsApisProvider);
  return ShipsNotiController(datasource: api);
});

class ShipsNotiController extends ChangeNotifier {
  final ShipsApisImplements _datasource;
  ShipsNotiController({required ShipsApisImplements datasource,})
      : _datasource = datasource,
        super();


  bool _isLoading = false;
  bool get isLoading=> _isLoading;
  setLoading(bool stat) {
    _isLoading = stat;
    notifyListeners();
  }

  bool _isSecondaryLoading = false;
  bool get isSecondaryLoading=> _isSecondaryLoading;
  setSecondaryLoading(bool stat) {
    _isSecondaryLoading = stat;
    notifyListeners();
  }


  List<VesselModel> _shipsModels = [];
  List<VesselModel> get shipsModels => _shipsModels;
  setChoferesModels(List<VesselModel> models) {
    _shipsModels = models;
    notifyListeners();
  }

  DocumentSnapshot? _lastSnapshot;
  DocumentSnapshot? get lastSnapshot=> _lastSnapshot;

  setLastSnapShot(DocumentSnapshot? snapshot) {
    _lastSnapshot = snapshot;
    notifyListeners();
  }


  int _limit = 10;
  int get limit=> _limit;

  setLimit({required int snapshot, required bool hasMoreData}) {
    _limit = snapshot;
    notifyListeners();
  }


  Future getAllShips({String? searchWord})async{
    if(searchWord!= null && searchWord!= ''){
      setSecondaryLoading(true);
      setChoferesModels([]);
      setLastSnapShot(null);
      QuerySnapshot querySnapshot = await _datasource.getAllShips(
        limit: limit,
        snapshot: _lastSnapshot,
      );
      List<VesselModel> models = [];
      List<String> filters = searchWord.split(' ');
      for (var document in querySnapshot.docs) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        bool matchesQuery = filters.every((field) => data['searchTags'][field] == true);
        if (matchesQuery) {
          VesselModel model = VesselModel.fromMap(data);
          models.add(model);
        }
      }
      setChoferesModels(models);

      if (querySnapshot.docs.isNotEmpty) {
        _lastSnapshot = querySnapshot.docs.last;
        _limit = _limit+10;
      }
      setSecondaryLoading(false);
      return models;

    }else if(searchWord == ''){

      setSecondaryLoading(true);
      QuerySnapshot querySnapshot = await _datasource.getAllShips(
        limit: limit,
        snapshot: _lastSnapshot,
      );

      List<VesselModel> models = [];
      for (var document in querySnapshot.docs) {
        var model = VesselModel.fromMap(document.data() as Map<String, dynamic>);
        _shipsModels.add(model);
      }

      if (querySnapshot.docs.isNotEmpty) {
        _lastSnapshot = querySnapshot.docs.last;
        _limit = _limit+10;
      }
      setSecondaryLoading(false);
      return models;
    }
    setSecondaryLoading(false);
  }


  Future firstTime()async{
    // if(lastSnapshot == null){
    _limit = 10;
    _lastSnapshot= null;
    _shipsModels = [];


      _isLoading = true;
      QuerySnapshot querySnapshot = await _datasource.getAllShips(limit: limit, snapshot: _lastSnapshot);

      List<VesselModel> models = [];
      for (var document in querySnapshot.docs) {
        var model = VesselModel.fromMap(document.data() as Map<String, dynamic>);
        models.add(model);
      }
      _shipsModels = models;
      if (querySnapshot.docs.isNotEmpty) {
        _lastSnapshot = querySnapshot.docs.last;
        _limit = _limit+10;
      }
      _isLoading = false;
      notifyListeners();
    // }
  }




}
