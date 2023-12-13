import 'dart:async';

import 'package:cargocontrol/commons/common_functions/search_tags_handler.dart';
import 'package:cargocontrol/models/choferes_models/choferes_model.dart';
import 'package:cargocontrol/models/industry_models/industries_model.dart';
import 'package:cargocontrol/models/industry_models/industry_guide_model.dart';
import 'package:cargocontrol/models/industry_models/industry_sub_model.dart';
import 'package:cargocontrol/routes/route_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../commons/common_widgets/show_toast.dart';
import '../data/apis/choferes_apis.dart';

final choferesControllerProvider = StateNotifierProvider<ChoferesController, bool>((ref) {
  final api = ref.watch(choferesApisProvider);
  return ChoferesController(datasource:  api, );
});


class ChoferesController extends StateNotifier<bool> {
  final ChoferesApisImplements _datasource;

  ChoferesController({required ChoferesApisImplements datasource,})
      : _datasource = datasource,
        super(false);

  Future<void> registerChofere({
    required String choferNationalId,
    required String firstName,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    state = true;
    final String choferId = const Uuid().v4();
    bool hasSecondName = hasLastName(firstName);
    ChoferesModel choferesModel = ChoferesModel(
        choferId: choferId,
        choferNationalId: choferNationalId,
        averageCargoDeficit: 0.0,
        averageTimeDeficit: DateTime.now(),
        rating: 5,
        numberOfTrips: 0,
        firstName: firstName,
        lastName: hasSecondName? firstName.split(' ').sublist(1).join(): '',
        rankingColor: 'Green',
      searchTags: choferesSearchTagsHandler(name: firstName, choferNationalId: choferNationalId)
    );

    final result = await _datasource.registerChofere(choferesModel: choferesModel);

    result.fold((l) {
      state = false;
      showSnackBar(context: context, content: l.message);
    }, (r) {
      state = false;
      Navigator.pop(context);
      showSnackBar(context: context, content: 'Choferes Registered!');
    });
    state = false;
  }

  bool hasLastName(String fullName) {
    int num = fullName.split(' ').length;
    return num > 1 ? true : false;
  }

  DocumentSnapshot? _lastSnapshot;
  DocumentSnapshot? get lastSnapshot=> _lastSnapshot;


  Future<List<ChoferesModel>> getAllChoferes({int limit = 10}) async {
    QuerySnapshot querySnapshot = await _datasource.getAllChoferes(limit: limit, snapshot: _lastSnapshot);

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
