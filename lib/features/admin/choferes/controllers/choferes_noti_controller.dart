import 'dart:async';

import 'package:cargocontrol/features/admin/choferes/data/apis/choferes_apis.dart';
import 'package:cargocontrol/models/industry_models/industries_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/choferes_models/choferes_model.dart';

final choferesNotiController = ChangeNotifierProvider((ref){
  final api = ref.watch(choferesApisProvider);
  return ChoferesNotiController(datasource: api);
});

class ChoferesNotiController extends ChangeNotifier {
  final ChoferesApisImplements _datasource;
  ChoferesNotiController({required ChoferesApisImplements datasource,})
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


  List<ChoferesModel> _choferesModels = [];
  List<ChoferesModel> get choferesModels => _choferesModels;
  setChoferesModels(List<ChoferesModel> models) {
    _choferesModels = models;
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


  Future getAllChoferes({String? searchWord})async{
    if(searchWord!= null && searchWord!= ''){
      setSecondaryLoading(true);
      setChoferesModels([]);
      setLastSnapShot(null);
      QuerySnapshot querySnapshot = await _datasource.getAllChoferes(
        limit: limit,
        snapshot: _lastSnapshot,
      );
      List<ChoferesModel> models = [];
      List<String> filters = searchWord.split(' ');
      for (var document in querySnapshot.docs) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        bool matchesQuery = filters.every((field) => data['searchTags'][field] == true);
        if (matchesQuery) {
          ChoferesModel model = ChoferesModel.fromMap(data);
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
      QuerySnapshot querySnapshot = await _datasource.getAllChoferes(
        limit: limit,
        snapshot: _lastSnapshot,
      );

      List<ChoferesModel> models = [];
      for (var document in querySnapshot.docs) {
        var model = ChoferesModel.fromMap(document.data() as Map<String, dynamic>);
        _choferesModels.add(model);
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
    _choferesModels = [];


      _isLoading = true;
      QuerySnapshot querySnapshot = await _datasource.getAllChoferes(limit: limit, snapshot: _lastSnapshot);

      List<ChoferesModel> models = [];
      for (var document in querySnapshot.docs) {
        var model = ChoferesModel.fromMap(document.data() as Map<String, dynamic>);
        models.add(model);
      }
      _choferesModels = models;
      if (querySnapshot.docs.isNotEmpty) {
        _lastSnapshot = querySnapshot.docs.last;
        _limit = _limit+10;
      }
      _isLoading = false;
      notifyListeners();
    // }
  }




}
