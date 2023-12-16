import 'package:cargocontrol/models/industry_models/industries_model.dart';
import 'package:cargocontrol/models/industry_models/industry_guide_model.dart';
import 'package:cargocontrol/models/industry_models/industry_sub_model.dart';
import 'package:cargocontrol/models/vessel_models/origin_model.dart';
import 'package:cargocontrol/models/vessel_models/product_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../commons/common_providers/global_providers.dart';
import '../../../../../core/constants/firebase_constants.dart';


final adIndustryApiProvider = Provider<AdIndustryApisImplements>((ref){
  final firestoreProvider = ref.watch(firebaseDatabaseProvider);
  return AdIndustryApis(firestore: firestoreProvider);
});


abstract class AdIndustryApisImplements {

  FutureEitherVoid createIndustryGuideModel({required List<IndustrySubModel> industrySubModels});
  FutureEitherVoid uploadIndustries({required IndustriesModel industryModell});
  FutureEither<List<IndustriesModel>> getAllIndustries();
  Stream<List<IndustrySubModel>> getAllIndustrySubModels();
  FutureEither<List<IndustrySubModel>> numberOfIndustriesCheck() ;
}

class AdIndustryApis implements AdIndustryApisImplements{
  final FirebaseFirestore _firestore;
  AdIndustryApis({required FirebaseFirestore firestore}): _firestore = firestore;


  @override
  FutureEitherVoid createIndustryGuideModel({required List<IndustrySubModel> industrySubModels}) async{
    try{
      industrySubModels.forEach((industrySubModel) async{
        await _firestore.collection(FirebaseConstants.industryGuideCollection).
        doc(industrySubModel.industryId).
        set(industrySubModel.toMap());
      });
      return const Right(null);
    }on FirebaseException catch(e, stackTrace){
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    }catch (e, stackTrace){
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  Stream<List<IndustrySubModel>> getAllIndustrySubModels(){
    return _firestore.collection(FirebaseConstants.industryGuideCollection).
    snapshots().
    map((event) {
      List<IndustrySubModel> models = [];
      event.docs.forEach((element) {
        models.add(IndustrySubModel.fromMap(element.data()));
      });
      return models;
    });
  }

  @override
  FutureEither<List<IndustrySubModel>> numberOfIndustriesCheck() async {
    try {
      var querySnapshot = await _firestore.collection(FirebaseConstants.industriesCollection).get();

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
  FutureEitherVoid uploadIndustries({required IndustriesModel industryModell})async {
    try{
      await _firestore.collection(FirebaseConstants.industriesCollection).
      doc(industryModell.industryId).
      set(industryModell.toMap());

      return Right(null);
    }on FirebaseException catch(e, stackTrace){
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    }catch (e, stackTrace){
      return Left(Failure(e.toString(), stackTrace));
    }
  }



  @override
  FutureEither<List<IndustriesModel>> getAllIndustries() async {
    try {
      var querySnapshot =
      await _firestore.collection(FirebaseConstants.industriesCollection).get();

      List<IndustriesModel> models = [];
      for (var document in querySnapshot.docs) {
        var model = IndustriesModel.fromMap(document.data());
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