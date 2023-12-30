import 'package:cargocontrol/features/admin/create_vessel/data/models/deficit_viejes_model.dart';
import 'package:cargocontrol/models/industry_models/industry_sub_model.dart';
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
  Stream<VesselModel> getCurrentVesselStream();
  FutureEither<VesselModel> getCurrentVessel();
  Stream<DeficitViajesModel> getCurrentVesselViajesDeficit({required String vesselId});
  Stream<DeficitViajesModel> getCargoHoldViajesDeficit({required String CargoHoldId});


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
  Stream<VesselModel> getCurrentVesselStream() {
    return _firestore.collection(FirebaseConstants.vesselCollection).
    where('isFinishedUnloading', isEqualTo: false).
    snapshots().map((event) {
      var model = VesselModel.fromMap(event.docs.first.data());
      return model;
    });
  }

  @override
  Stream<DeficitViajesModel> getCurrentVesselViajesDeficit({required String vesselId}) {
    return _firestore.collection(FirebaseConstants.industryGuideCollection).where("vesselId",isEqualTo: vesselId).
    snapshots().
    map((event) {
      int viajesCount = 0;
      double deficit = 0;
      event.docs.forEach((element) {
        IndustrySubModel industrySubModel =IndustrySubModel.fromMap(element.data());
        viajesCount = viajesCount + industrySubModel.viajesIds.length;
        deficit=deficit + industrySubModel.deficit;
      });
      DeficitViajesModel model = DeficitViajesModel(viajesCount: viajesCount.toString(), totalDeficit: deficit.toString());
      return model;
    });
  }

  @override
  Stream<DeficitViajesModel> getCargoHoldViajesDeficit({required String CargoHoldId}) {
    return _firestore.collection(FirebaseConstants.industryGuideCollection).where("cargoHoldId",isEqualTo: CargoHoldId).
    snapshots().
    map((event) {
      int viajesCount = 0;
      double deficit = 0;
      event.docs.forEach((element) {
        IndustrySubModel industrySubModel =IndustrySubModel.fromMap(element.data());
        viajesCount = viajesCount + industrySubModel.viajesIds.length;
        deficit=deficit + industrySubModel.deficit;
      });
      DeficitViajesModel model = DeficitViajesModel(viajesCount: viajesCount.toString(), totalDeficit: deficit.toString());
      return model;
    });
  }

  @override
  FutureEither<VesselModel> getCurrentVessel() async {
    try {
      var querySnapshot =
      await _firestore.collection(FirebaseConstants.vesselCollection). where('isFinishedUnloading', isEqualTo: false).get();
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