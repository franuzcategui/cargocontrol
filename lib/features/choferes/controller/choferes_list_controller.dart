import 'dart:async';
import 'package:async/async.dart';

import 'package:cargocontrol/features/choferes/controller/add_choferes_controller.dart';
import 'package:cargocontrol/features/choferes/controller/chofer_info.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChoferesListController extends StreamNotifier<List<ChoferInfo>> {
  final pageSize = 5;
  bool _hasMore = true;
  DataSnapshot? lastDoc;
  Stream<List<ChoferInfo>>? choferStream;

  bool get hasMore => _hasMore;

  @override
  Stream<List<ChoferInfo>> build() async* {
    state = const AsyncLoading();
    // show loading indicator
    choferStream = _listenToChoferesList();
    yield* choferStream ?? const Stream.empty();
  }

  Future<void> fetchMore() async {
    if (state.isLoading || !hasMore || lastDoc == null) return;

    print('llego aca');
    final newChoferes = _listenToChoferesList();
    choferStream = StreamGroup.merge([choferStream!, newChoferes]);

    //print ChoferInfo values from the new stream
    print(choferStream!);

    // final test = state.value;
    // for (final chofer in test!) {
    //   print(chofer.nombre);
    // }
  }

  //create method that concatinates the current state stream with the new stream fetched in _listentoChoferesList

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
        print(lastDoc!.key);
      }
      return result;
    });
  }

//   Future<void> _StreamChoferesList() async {
//     await Future.delayed(const Duration(milliseconds: 1000));

//     final newState = await AsyncValue.guard(() async {
//       return ref
//           .read(choferesRepoProvider)
//           .listenToChoferesList(pageSize: pageSize, lastDoc: lastDoc)
//           .map((event) {
//         final result = event.$1;
//         _hasMore = result.isNotEmpty;
//         final lastDocument = event.$2;
//         if (lastDocument != null) {
//           lastDoc = lastDocument;
//         }
//         return result;
//       });
//     });
//     final newUsers = await newState.value!.toList();
//   }
}

final choferListControllerProvider =
    StreamNotifierProvider<ChoferesListController, List<ChoferInfo>>(
        ChoferesListController.new);
