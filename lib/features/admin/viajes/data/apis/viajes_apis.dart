import 'package:cargocontrol/core/enums/viajes_type.dart';
import 'package:cargocontrol/models/choferes_models/choferes_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../commons/common_providers/global_providers.dart';
import '../../../../../core/constants/firebase_constants.dart';
import '../../../../../models/industry_models/industry_sub_model.dart';
import '../../../../../models/vessel_models/vessel_model.dart';
import '../../../../../models/viajes_models/viajes_model.dart';


final viajesApisProvider = Provider<ViajesApisImplements>((ref){
  final firestoreProvider = ref.watch(firebaseDatabaseProvider);
  return ViajesApis(firestore: firestoreProvider);
});


abstract class ViajesApisImplements {

  Future<QuerySnapshot> getAllViajes({int limit = 10, DocumentSnapshot? snapshot,required String vesselId});
  Future<QuerySnapshot> getCompletedViajes({int limit = 10, DocumentSnapshot? snapshot,required String vesselId});
  Future<QuerySnapshot> getInprogressViajes({int limit = 10, DocumentSnapshot? snapshot,required String vesselId});
  FutureEither<List<IndustrySubModel>> getAllIndustries({required String vesselId});
  FutureEither<IndustrySubModel> getIndustryGuideModel({required String industryId});
  FutureEitherVoid updateViajesModels({required ViajesModel viajesModel, required VesselModel vesselModel,
    required IndustrySubModel currentIndustryModel, required IndustrySubModel updatedIndustryModel});

}

class ViajesApis implements ViajesApisImplements{
  final FirebaseFirestore _firestore;
  ViajesApis({required FirebaseFirestore firestore}): _firestore = firestore;





  @override
  Future<QuerySnapshot> getAllViajes({int limit = 10, DocumentSnapshot? snapshot,required String vesselId}) async {
    Query query = _firestore.collection(FirebaseConstants.viajesCollection).where('vesselId',isEqualTo: vesselId);

    if (snapshot != null) {
      query = query.limit(limit).startAfterDocument(snapshot);
    } else {
      query = query.limit(limit);
    }

    return await query.get();
  }

  @override
  Future<QuerySnapshot> getInprogressViajes({int limit = 10, DocumentSnapshot? snapshot,required String vesselId}) async {
    Query query = _firestore.collection(FirebaseConstants.viajesCollection).where('viajesTypeEnum',isEqualTo: ViajesTypeEnum.inProgress.type).where('vesselId',isEqualTo: vesselId);

    if (snapshot != null) {
      query = query.limit(limit).startAfterDocument(snapshot);
    } else {
      query = query.limit(limit);
    }

    return await query.get();
  }
  @override
  Future<QuerySnapshot> getCompletedViajes({int limit = 10, DocumentSnapshot? snapshot,required String vesselId}) async {
    Query query = _firestore.collection(FirebaseConstants.viajesCollection).where('viajesTypeEnum',isEqualTo: ViajesTypeEnum.completed.type).where('vesselId',isEqualTo: vesselId);

    if (snapshot != null) {
      query = query.limit(limit).startAfterDocument(snapshot);
    } else {
      query = query.limit(limit);
    }

    return await query.get();
  }


  @override
  FutureEither<List<IndustrySubModel>> getAllIndustries({required String vesselId}) async {
    try {
      var querySnapshot = await _firestore.collection(FirebaseConstants.industryGuideCollection).where("vesselId",isEqualTo: vesselId).get();

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
  FutureEither<IndustrySubModel> getIndustryGuideModel({required String industryId}) async{
    try{
      final querySnapshot = await _firestore.collection(FirebaseConstants.industryGuideCollection).
      where('industryId', isEqualTo: industryId).
      get();
      if(querySnapshot.docs.length!=0){
        IndustrySubModel model = IndustrySubModel.fromMap(querySnapshot.docs.first.data());
        return Right(model);
      }else{
        return Left(Failure('No Industry Found!', StackTrace.fromString('getIndustriaIndustrywithFuture')));
      }
    }on FirebaseException catch(e, stackTrace){
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    }catch (e, stackTrace){
      return Left(Failure(e.toString(), stackTrace));
    }
  }


  @override
  FutureEitherVoid updateViajesModels({required ViajesModel viajesModel, required VesselModel vesselModel,
    required IndustrySubModel currentIndustryModel, required IndustrySubModel updatedIndustryModel}) async {
    try{
      await _firestore.runTransaction((Transaction transaction) async {
        transaction.update(
          _firestore.collection(FirebaseConstants.viajesCollection).
          doc(viajesModel.viajesId),
          viajesModel.toMap(),
        );
        transaction.update(
          _firestore.collection(FirebaseConstants.vesselCollection).
          doc(vesselModel.vesselId),
          vesselModel.toMap(),
        );
        transaction.update(
          _firestore.collection(FirebaseConstants.industryGuideCollection).
          doc(currentIndustryModel.industryId),
          currentIndustryModel.toMap(),
        );
        transaction.update(
          _firestore.collection(FirebaseConstants.industryGuideCollection).
          doc(updatedIndustryModel.industryId),
          updatedIndustryModel.toMap(),
        );
      });
      return Right(null);
    }on FirebaseException catch(e, stackTrace){
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    }catch (e, stackTrace){
      return Left(Failure(e.toString(), stackTrace));
    }
  }

}