import 'package:cargocontrol/models/vessel_models/origin_model.dart';
import 'package:cargocontrol/models/vessel_models/product_model.dart';
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
  FutureEither<VesselModel> getCurrentVessel();

  FutureEitherVoid uploadProduct({required ProductModel productModel});
  FutureEitherVoid uploadOrigins({required OriginModel originModel});

  Stream<ProductModel> getProductModel({required String productId});
  FutureEither<List<ProductModel>> getAllProducts();
  FutureEither<OriginModel> getAllOrigins();
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
  FutureEitherVoid uploadProduct({required ProductModel productModel})async {
    try{
      await _firestore.collection(FirebaseConstants.productsCollection).
      doc(productModel.productId).
      set(productModel.toMap());

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
  FutureEither<VesselModel> getCurrentVessel() async {
    try {
      var querySnapshot =
      await _firestore.collection(FirebaseConstants.vesselCollection).get();
      var model = VesselModel.fromMap(querySnapshot.docs.first.data());
      return Right(model);
    } on FirebaseAuthException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }


  @override
  Stream<ProductModel> getProductModel({required String productId}){
    return _firestore.collection(FirebaseConstants.productsCollection).
    where('productId', isNotEqualTo:  productId).
    snapshots().map((event) {
      var model = ProductModel.fromMap(event.docs.first.data());
      return model;
    });
  }



  @override
  FutureEither<List<ProductModel>> getAllProducts() async {
    try {
      var querySnapshot =
      await _firestore.collection(FirebaseConstants.productsCollection).get();

      List<ProductModel> models = [];
      for (var document in querySnapshot.docs) {
        var model = ProductModel.fromMap(document.data());
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
  FutureEither<OriginModel> getAllOrigins() async {
    try {
      var querySnapshot =
      await _firestore.collection(FirebaseConstants.originsCollection).get();

      if (querySnapshot.docs.isNotEmpty) {
        var model = OriginModel.fromMap(querySnapshot.docs.first.data());
        return Right(model);
      } else{
        return Left(Failure('No Origins Found!', StackTrace.fromString('getAllOrigins')));
      }

    } on FirebaseAuthException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  
}