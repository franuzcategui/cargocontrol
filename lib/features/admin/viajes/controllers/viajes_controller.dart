import 'dart:async';

import 'package:cargocontrol/commons/common_functions/search_tags_handler.dart';
import 'package:cargocontrol/core/enums/choferes_status_enum.dart';
import 'package:cargocontrol/features/admin/choferes/controllers/choferes_noti_controller.dart';
import 'package:cargocontrol/models/choferes_models/choferes_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../commons/common_widgets/show_toast.dart';
import '../data/apis/viajes_apis.dart';

final viajesControllerProvider = StateNotifierProvider<ViajesController, bool>((ref) {
  final api = ref.watch(viajesApisProvider);
  return ViajesController(datasource:  api, );
});


class ViajesController extends StateNotifier<bool> {
  final ViajesApisImplements _datasource;

  ViajesController({required ViajesApisImplements datasource,})
      : _datasource = datasource,
        super(false);

  DocumentSnapshot? _lastSnapshot;
  DocumentSnapshot? get lastSnapshot=> _lastSnapshot;


  Future<List<ChoferesModel>> getAllViajes({int limit = 10}) async {
    QuerySnapshot querySnapshot = await _datasource.getAllViajes(limit: limit, snapshot: _lastSnapshot);

    List<ChoferesModel> models = [];
    for (var document in querySnapshot.docs) {
      var model = ChoferesModel.fromMap(document.data() as Map<String, dynamic>);
      models.add(model);
    }

    if (querySnapshot.docs.isNotEmpty) {
      _lastSnapshot = querySnapshot.docs.last;
    }

    print('Length: ${querySnapshot.docs.length}');
    return models;
  }



}
