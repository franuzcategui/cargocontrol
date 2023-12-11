import 'package:cargocontrol/models/vessel_models/cosecha_model.dart';
import 'package:cargocontrol/models/vessel_models/origin_model.dart';
import 'package:cargocontrol/models/vessel_models/product_model.dart';
import 'package:cargocontrol/models/vessel_models/tipo_model.dart';
import 'package:cargocontrol/models/vessel_models/variety_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../commons/common_providers/global_providers.dart';
import '../../../../../core/constants/firebase_constants.dart';


final adVesselApiProvider = Provider<AdVesselApisImplements>((ref){
  final firestoreProvider = ref.watch(firebaseDatabaseProvider);
  return AdVesselApis(firestore: firestoreProvider);
});


abstract class AdVesselApisImplements {

  FutureEitherVoid createVessel({required VesselModel vesselModel});
  Stream<List<VesselModel>> getVesselsList();

  FutureEitherVoid uploadProducts({required ProductModel productModel});
  FutureEitherVoid uploadTipos({required TipoModel tipoModel});
  FutureEitherVoid uploadOrigins({required OriginModel originModel});
  FutureEitherVoid uploadVarieties({required VarietyModel varietyModel});
  FutureEitherVoid uploadCosecha({required CosechaModel cosechaModel});

  Stream<VarietyModel> getVarietyModel();
  Stream<OriginModel> getOriginModel();
  Stream<ProductModel> getProductModel();
  Stream<CosechaModel> getCosechaModel();
  Stream<TipoModel> getTipoModel();
}

class AdVesselApis implements AdVesselApisImplements{
  final FirebaseFirestore _firestore;
  AdVesselApis({required FirebaseFirestore firestore}): _firestore = firestore;

  @override
  FutureEitherVoid createVessel({required VesselModel vesselModel}) async{
    try{
      await _firestore.collection(FirebaseConstants.vesselCollection).
      doc(vesselModel.vesselId).
      set(vesselModel.toMap());

      return const Right(null);
    }on FirebaseException catch(e, stackTrace){
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    }catch (e, stackTrace){
      return Left(Failure(e.toString(), stackTrace));
    }
  }



  @override
  FutureEitherVoid uploadProducts({required ProductModel productModel})async {
    try{
      await _firestore.collection(FirebaseConstants.productsCollection).
      add(productModel.toMap());

      return Right(null);
    }on FirebaseException catch(e, stackTrace){
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    }catch (e, stackTrace){
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEitherVoid uploadTipos({required TipoModel tipoModel})async {
    try{
      await _firestore.collection(FirebaseConstants.tiposCollection).
      add(tipoModel.toMap());

      return Right(null);
    }on FirebaseException catch(e, stackTrace){
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    }catch (e, stackTrace){
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEitherVoid uploadOrigins({required OriginModel originModel})async {
    try{
      await _firestore.collection(FirebaseConstants.originsCollection).
      add(originModel.toMap());

      return Right(null);
    }on FirebaseException catch(e, stackTrace){
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    }catch (e, stackTrace){
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEitherVoid uploadVarieties({required VarietyModel varietyModel})async {
    try{
      await _firestore.collection(FirebaseConstants.varietiesCollection).
      add(varietyModel.toMap());

      return Right(null);
    }on FirebaseException catch(e, stackTrace){
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    }catch (e, stackTrace){
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEitherVoid uploadCosecha({required CosechaModel cosechaModel})async {
    try{
      await _firestore.collection(FirebaseConstants.cosechaCollection).
      add(cosechaModel.toMap());

      return Right(null);
    }on FirebaseException catch(e, stackTrace){
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    }catch (e, stackTrace){
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  Stream<List<VesselModel>> getVesselsList() {
    return _firestore.collection(FirebaseConstants.vesselCollection).snapshots().map((event) {
      List<VesselModel> models = [];
      for (var document in event.docs) {
        var model = VesselModel.fromMap(document.data());
        models.add(model);
      }
      return models;
    });
  }

  @override
  Stream<VarietyModel> getVarietyModel(){
    return _firestore.collection(FirebaseConstants.varietiesCollection).snapshots().map((event) {
      var model = VarietyModel.fromMap(event.docs.first.data());
      return model;
    });
  }
  
}