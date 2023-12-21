import 'package:cargocontrol/models/choferes_models/choferes_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../commons/common_providers/global_providers.dart';
import '../../../../../core/constants/firebase_constants.dart';


final choferesApisProvider = Provider<ChoferesApisImplements>((ref){
  final firestoreProvider = ref.watch(firebaseDatabaseProvider);
  return ChoferesApis(firestore: firestoreProvider);
});


abstract class ChoferesApisImplements {

  FutureEitherVoid registerChofere({required ChoferesModel choferesModel});
  FutureEitherVoid deleteChofere({required String chofereId});
  Future<QuerySnapshot> getAllChoferes({int limit = 10, DocumentSnapshot? snapshot});
}

class ChoferesApis implements ChoferesApisImplements{
  final FirebaseFirestore _firestore;
  ChoferesApis({required FirebaseFirestore firestore}): _firestore = firestore;


  @override
  FutureEitherVoid registerChofere({required ChoferesModel choferesModel}) async{
    try{
      await _firestore.collection(FirebaseConstants.choferesCollection).
      doc(choferesModel.choferNationalId).
      set(choferesModel.toMap());

      return const Right(null);
    }on FirebaseException catch(e, stackTrace){
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    }catch (e, stackTrace){
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEitherVoid deleteChofere({required String chofereId}) async{
    try{
      await _firestore.collection(FirebaseConstants.choferesCollection).
      doc(chofereId).
      delete();

      return const Right(null);
    }on FirebaseException catch(e, stackTrace){
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    }catch (e, stackTrace){
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  Future<QuerySnapshot> getAllChoferes({int limit = 10, DocumentSnapshot? snapshot}) async {
    Query query = _firestore.collection(FirebaseConstants.choferesCollection);

    if (snapshot != null) {
      query = query.limit(limit).startAfterDocument(snapshot);
    } else {
      query = query.limit(limit);
    }

    return await query.get();
  }



}