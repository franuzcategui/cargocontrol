import 'dart:async';

import 'package:cargocontrol/features/choferes/controller/add_choferes_controller.dart';
import 'package:cargocontrol/features/choferes/controller/chofer_info.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChoferesListController extends StreamNotifier<List<ChoferInfo>> {
  final pageSize = 10;
  bool _hasMore = true;
  DataSnapshot? lastDoc;

  @override
  Stream<List<ChoferInfo>> build() async* {
    yield* _listenToChoferesList();
    print(state.value);
  }

  Future<void> fetchMore() async {
    if (state.isLoading || !_hasMore || lastDoc == null) return;

    state = const AsyncLoading();
    final newState = await AsyncValue.guard(() async {
      final newUsers = await _fetchChoferes();
      return [...?state.value, ...newUsers];
    });
    state = newState;
  }

  Future<List<ChoferInfo>> _fetchChoferes() async {
    await Future.delayed(const Duration(milliseconds: 1000));

    final result = await ref
        .read(choferesRepoProvider)
        .fetchChoferes(pageSize: pageSize, lastDoc: lastDoc);

    _hasMore = result.$1.isNotEmpty;

    final lastDocument = result.$2;

    if (lastDocument != null) {
      lastDoc = lastDocument;
    }

    return result.$1;
  }

  Stream<List<ChoferInfo>> _listenToChoferesList() {
    return ref
        .read(choferesRepoProvider)
        .listenToChoferesList(pageSize: pageSize, lastDoc: lastDoc)
        .map((event) {
      final result = event.$1;
      _hasMore = result.isNotEmpty;
      final lastDocument = event.$2;
      if (lastDocument != null) {
        lastDoc = lastDocument;
      }
      return result;
    });
  }
}

final choferListControllerProvider =
    StreamNotifierProvider<ChoferesListController, List<ChoferInfo>>(
        ChoferesListController.new);
