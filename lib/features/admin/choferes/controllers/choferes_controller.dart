import 'dart:async';

import 'package:cargocontrol/commons/common_functions/search_tags_handler.dart';
import 'package:cargocontrol/core/enums/choferes_status_enum.dart';
import 'package:cargocontrol/features/admin/choferes/controllers/choferes_noti_controller.dart';
import 'package:cargocontrol/features/admin/choferes/data/models/choferes_time_deficit_model.dart';
import 'package:cargocontrol/models/choferes_models/choferes_model.dart';
import 'package:cargocontrol/models/industry_models/industries_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../commons/common_widgets/show_toast.dart';
import '../../../../models/viajes_models/viajes_model.dart';
import '../data/apis/choferes_apis.dart';

final choferesControllerProvider =
    StateNotifierProvider<ChoferesController, bool>((ref) {
  final api = ref.watch(choferesApisProvider);
  return ChoferesController(
    datasource: api,
  );
});

final getChoferesCargoDeficitPercentile =
    FutureProvider.family.autoDispose((ref, ChoferesModel choferesModel) {
  final ctr = ref.watch(choferesControllerProvider.notifier);
  return ctr.choferesCargoDeficitPercentile(choferesModel: choferesModel);
});

final getChoferesTimeDeficitModel =
    FutureProvider.family.autoDispose((ref, ChoferesModel choferesModel) {
  final ctr = ref.watch(choferesControllerProvider.notifier);
  return ctr.choferesTimeDeficitModel(choferesModel: choferesModel);
});

class ChoferesController extends StateNotifier<bool> {
  final ChoferesApisImplements _datasource;

  ChoferesController({
    required ChoferesApisImplements datasource,
  })  : _datasource = datasource,
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
        choferesStatusEnum: ChoferesStatusEnum.available,
        choferNationalId: choferNationalId,
        averageCargoDeficit: 0.0,
        averageTimeDeficit: Duration(),
        rating: 5,
        numberOfTrips: 0,
        firstName: hasSecondName
            ? firstName.split(' ').sublist(0, 1).join()
            : firstName,
        lastName: hasSecondName ? firstName.split(' ').sublist(1).join() : '',
        rankingColor: 'Green',
        searchTags: choferesSearchTagsHandler(
            name: firstName, choferNationalId: choferNationalId),
        worstCargoDeficit: 0.0,
        createdAt: DateTime.now(),
        worstTimeDeficit: Duration(),
        averageCargoDeficitPercentage: 0.0,
        worstCargoDeficitPercentage: 0.0);

    final result =
        await _datasource.registerChofere(choferesModel: choferesModel);

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

  Future<void> deleteChofere({
    required String choferNationalId,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    state = true;
    final result = await _datasource.deleteChofere(chofereId: choferNationalId);

    result.fold((l) {
      state = false;
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message);
      showSnackBar(context: context, content: l.message);
    }, (r) async {
      await ref.read(choferesNotiController).firstTime();
      state = false;
      showSnackBar(context: context, content: 'Choferes Deleted!');
    });
    state = false;
  }

  bool hasLastName(String fullName) {
    int num = fullName.split(' ').length;
    return num > 1 ? true : false;
  }

  DocumentSnapshot? _lastSnapshot;
  DocumentSnapshot? get lastSnapshot => _lastSnapshot;

  Future<List<ChoferesModel>> getAllChoferes({int limit = 10}) async {
    QuerySnapshot querySnapshot =
        await _datasource.getAllChoferes(limit: limit, snapshot: _lastSnapshot);

    List<ChoferesModel> models = [];
    for (var document in querySnapshot.docs) {
      var model =
          ChoferesModel.fromMap(document.data() as Map<String, dynamic>);
      models.add(model);
    }

    if (querySnapshot.docs.isNotEmpty) {
      _lastSnapshot = querySnapshot.docs.last;
    }

    print('Length: ${querySnapshot.docs.length}');
    return models;
  }

  Future<double> choferesCargoDeficitPercentile(
      {required ChoferesModel choferesModel}) async {
    // Step 1: Get all the choferes
    // Step 2: Arrange them based on average cargo deficit in descending order
    // Step 3: Get the current chofer's index in the sorted list
    // Step 4: Calculate the percentile
    // Step 5: return the percentile
    try {
      QuerySnapshot querySnapshot = await _datasource.getAllChoferesList();
      List<ChoferesModel> models = [];
      querySnapshot.docs.forEach((element) {
        models
            .add(ChoferesModel.fromMap(element.data() as Map<String, dynamic>));
      });
      models.sort((a, b) => b.averageCargoDeficitPercentage
          .compareTo(a.averageCargoDeficitPercentage));

      // Find the index of the target chofer in the sorted list
      int index = -1;
      for (var i = 0; i < models.length; i++) {
        if (models[i].choferNationalId == choferesModel.choferNationalId) {
          index = i;
        }
      }

      // Calculate the percentile
      double totalChoferes = models.length.toDouble();
      double percentile = (index + 1) / totalChoferes * 100;
      return percentile;
    } catch (ex) {
      print(ex);
      return 0.0;
    }
  }

  Future<List<ChoferesTimeDeficitModel>> choferesTimeDeficitModel(
      {required ChoferesModel choferesModel}) async {
    // Step 1: get all vaijes that are completed
    // step 2 : make group based on real industry id
    // step 3 : get a average of trip time for each industry
    // step 4: get this chofer vaijes for each inustry and  iterrateb throgh it to time deficit
    // step 5: get the sum of time deficit / number of vaijes
    // step 6: return the list max limit 4.(Conatining industry name, industry id, duaration)
    List<IndustriesModel> realIndustries = [];
    List<ChoferesTimeDeficitModel> choferesTimeDeficitModels = [];
    try {
      //Step 1: get all the Real Industries
      final allRealIndustriesResult = await _datasource.getAllIndustries();
      allRealIndustriesResult.fold((l) {
        debugPrintStack(stackTrace: l.stackTrace);
        debugPrint(l.message);
        return choferesTimeDeficitModels;
      }, (r) {
        realIndustries = r;
      });

      for (var realIndustryModel in realIndustries) {
        List<ViajesModel> industryRelatedViajesModel = [];
        final industryRelatedViajesModelResult =
            await _datasource.getAllCompletedViajesList(
                realIndustryId: realIndustryModel.industryId);
        industryRelatedViajesModelResult.fold((l) {
          debugPrintStack(stackTrace: l.stackTrace);
          debugPrint(l.message);
          //return choferesTimeDeficitModels;
        }, (r) {
          industryRelatedViajesModel = r;
        });

        if (industryRelatedViajesModel.isEmpty) {
          continue;
        }
        List<ViajesModel> filteredViajesList = industryRelatedViajesModel
            .where((viaje) => viaje.chofereId == choferesModel.choferNationalId)
            .toList();
        if (filteredViajesList.isEmpty) {
          continue;
        }

        // Calculate the total trip time and count of ViajesModel instances
        Duration totalTripTime = Duration.zero;
        int viajesCount = 0;

        for (ViajesModel viaje in industryRelatedViajesModel) {
          totalTripTime += viaje.tripTime;
          viajesCount++;
        }

        // Calculate the average trip time
        Duration averageTripTime = viajesCount > 0
            ? Duration(
                milliseconds: totalTripTime.inMilliseconds ~/ viajesCount)
            : Duration.zero;
print("============");
        List<Duration> timeDeficitList = [];
        for (ViajesModel viaje in filteredViajesList) {
          print("Average Trip Time: "+averageTripTime.toString());
          print( "trip time: "+ viaje.tripTime.toString());
          Duration timeDeficit = viaje.tripTime - averageTripTime;
          timeDeficitList.add(timeDeficit);
        }

        // Find the worst and average time deficit
        print("Time deficit List"+ timeDeficitList.toString());
        print("============");
        Duration worstTimeDeficit = timeDeficitList.isEmpty
            ? Duration.zero
            : timeDeficitList
                .reduce((value, element) => value > element ? value : element);

        Duration avgTimeDeficit = timeDeficitList.isEmpty
            ? Duration.zero
            : Duration(
                milliseconds: timeDeficitList.fold(
                        0, (sum, element) => sum + element.inMilliseconds) ~/
                    timeDeficitList.length);

        ChoferesTimeDeficitModel choferesTimeDeficitModel =
            ChoferesTimeDeficitModel(
                choferesId: choferesModel.choferNationalId,
                choferesName: choferesModel.firstName,
                realIndustryId: realIndustryModel.industryId,
                industryName: realIndustryModel.industryName,
                avgTimeDeficit: avgTimeDeficit,
                worstTimeDeficit: worstTimeDeficit);

        choferesTimeDeficitModels.add(choferesTimeDeficitModel);
      }
      return choferesTimeDeficitModels;
    } catch (ex) {
      print(ex);
      return choferesTimeDeficitModels;
    }
  }
}
