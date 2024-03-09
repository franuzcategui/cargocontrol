import 'package:cargocontrol/models/choferes_models/choferes_model.dart';
import 'package:cargocontrol/models/industry_models/industry_sub_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../commons/common_providers/global_providers.dart';
import '../../../../../core/constants/firebase_constants.dart';
import '../../../../../core/enums/choferes_status_enum.dart';
import '../../../../../models/industry_models/industries_model.dart';
import '../../../../../models/viajes_models/viajes_model.dart';

final shipsApisProvider = Provider<ShipsApisImplements>((ref) {
  final firestoreProvider = ref.watch(firebaseDatabaseProvider);
  return ShipApis(firestore: firestoreProvider);
});

abstract class ShipsApisImplements {
  FutureEitherVoid finishVesselUnloading({required VesselModel vesselModel});
  FutureEitherVoid makeAllChoferesAvailable();

  Future<QuerySnapshot> getAllShips(
      {int limit = 10, DocumentSnapshot? snapshot});
  FutureEither<List<ViajesModel>> getAllViajes({required String vesselId});
  FutureEither<List<ViajesModel>> getAllViajesForIndustry({required String vesselId,required String realIndustryId});
  FutureEither<List<IndustrySubModel>> getAllIndustrySubModels({required String vesselId});
  FutureEither<List<IndustrySubModel>> getAllIndustrySubModelsforIndustry({required String vesselId,required String realIndustryId});

}

class ShipApis implements ShipsApisImplements {
  final FirebaseFirestore _firestore;
  ShipApis({required FirebaseFirestore firestore}) : _firestore = firestore;

  @override
  FutureEitherVoid finishVesselUnloading(
      {required VesselModel vesselModel}) async {
    try {
      await _firestore
          .collection(FirebaseConstants.vesselCollection)
          .doc(vesselModel.vesselId)
          .update(vesselModel.toMap());

      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEitherVoid makeAllChoferesAvailable() async {
    try {
      final CollectionReference chofersCollection =
          _firestore.collection(FirebaseConstants.choferesCollection);
      // Fetch all documents from the collection
      QuerySnapshot chofers = await chofersCollection.get();

      // Update "choferesStatusEnum" field for each document
      for (QueryDocumentSnapshot doc in chofers.docs) {
        await chofersCollection.doc(doc.id).update({
          'choferesStatusEnum': ChoferesStatusEnum.available.type,
        });
      }

      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  Future<QuerySnapshot> getAllShips(
      {int limit = 10, DocumentSnapshot? snapshot}) async {
    Query query = _firestore.collection(FirebaseConstants.vesselCollection);

    if (snapshot != null) {
      query = query.limit(limit).startAfterDocument(snapshot);
    } else {
      query = query.limit(limit);
    }

    return await query.get();
  }


  @override
  FutureEither<List<IndustrySubModel>> getAllIndustrySubModels({required String vesselId}) async {
    try {
      var querySnapshot =
          await _firestore.collection(FirebaseConstants.industryGuideCollection).where("vesselId",isEqualTo: vesselId).get();

      List<IndustrySubModel> models = [];
      for (var document in querySnapshot.docs) {
        var model = IndustrySubModel.fromMap(document.data());
        models.add(model);
      }

      return Right(models);
    } on FirebaseAuthException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEither<List<ViajesModel>> getAllViajes({required String vesselId}) async {
    try {
      var querySnapshot =
      await _firestore.collection(FirebaseConstants.viajesCollection).where("vesselId",isEqualTo: vesselId).get();

      List<ViajesModel> models = [];
      for (var document in querySnapshot.docs) {
        var model = ViajesModel.fromMap(document.data());
        models.add(model);
      }

      return Right(models);
    } on FirebaseAuthException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }




  @override
  FutureEither<List<IndustrySubModel>> getAllIndustrySubModelsforIndustry({required String vesselId,required String realIndustryId}) async {
    try {
      var querySnapshot =
      await _firestore.collection(FirebaseConstants.industryGuideCollection).where("vesselId",isEqualTo: vesselId).where("realIndustryId",isEqualTo: realIndustryId).get();

      List<IndustrySubModel> models = [];
      for (var document in querySnapshot.docs) {
        var model = IndustrySubModel.fromMap(document.data());
        models.add(model);
      }

      return Right(models);
    } on FirebaseAuthException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEither<List<ViajesModel>> getAllViajesForIndustry({required String vesselId,required String realIndustryId}) async {
    try {
      var querySnapshot =
      await _firestore.collection(FirebaseConstants.viajesCollection).where("vesselId",isEqualTo: vesselId).where("realIndustryId",isEqualTo: realIndustryId).get();

      List<ViajesModel> models = [];
      for (var document in querySnapshot.docs) {
        var model = ViajesModel.fromMap(document.data());
        models.add(model);
      }

      return Right(models);
    } on FirebaseAuthException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }
}

