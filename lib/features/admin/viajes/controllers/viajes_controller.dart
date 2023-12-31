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


}
