import 'package:cargocontrol/core/enums/account_type.dart';
import 'package:cargocontrol/core/enums/viajes_status_enum.dart';
import 'package:cargocontrol/core/enums/viajes_type.dart';
import 'package:cargocontrol/models/auth_models/user_model.dart';
import 'package:cargocontrol/models/choferes_models/choferes_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_model.dart';
import 'package:cargocontrol/models/viajes_models/viajes_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../commons/common_providers/global_providers.dart';
import '../../../../../core/constants/firebase_constants.dart';
import '../../../../../models/industry_models/industry_sub_model.dart';
import '../../../../../models/misc_models/industry_vessel_ids_model.dart';


final truckRegistrationApisProvider = Provider<TruckRegistrationApisImplements>((ref){
  final firestoreProvider = ref.watch(firebaseDatabaseProvider);
  return TruckRegistrationApis(firestore: firestoreProvider);
});


abstract class TruckRegistrationApisImplements {

  FutureEitherVoid registerTruckEnteringToPort({
    required ViajesModel viajesModel,
    required IndustrySubModel industrySubModel,
    required ChoferesModel choferesModel,
  });
  FutureEitherVoid registerTruckLeavingFromPort({required ViajesModel viajesModel, required VesselModel vesselModel,});
  FutureEitherVoid registerTruckEnteringInIndustry({required ViajesModel viajesModel, required IndustrySubModel industrySubModel,}) ;
  FutureEitherVoid registerTruckUnloadingInIndustry({
    required ViajesModel viajesModel,
    required IndustrySubModel industrySubModel,
    required ChoferesModel choferesModel,
  });

  Stream<QuerySnapshot<Map<String, dynamic>>> getLAllViajesModels();
  Stream<QuerySnapshot<Map<String, dynamic>>> getPortEnteringViajesList({required String vesselId});
  Stream<QuerySnapshot<Map<String, dynamic>>> getPortLeavingViajesList({required String vesselId});
  Stream<QuerySnapshot<Map<String, dynamic>>> getPortAllInProgressViajesList({required String industryId});
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllCurrentVesselInProgressViajesList({required String vesselId});
  Stream<QuerySnapshot<Map<String, dynamic>>> getIndustryEnteringViajesList();
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllViajesList({required String vesselId});
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllViajesForIndustryList({required IndustryAndVesselIdsModel industryAndVesselIdsModel});
  Stream<QuerySnapshot<Map<String, dynamic>>> getIndustriaIndustry({required IndustryAndVesselIdsModel industryAndVesselIdsModel});
  Stream<QuerySnapshot<Map<String, dynamic>>> getIndustriaIndustryByIndustryId({required String industryId});
  Stream<QuerySnapshot<Map<String, dynamic>>> getChoferModelByNationalId({required String nationalId});

  FutureEither<List<IndustrySubModel>> getAllIndustries({required String vesselId});
  FutureEither<ViajesModel> getMatchedViajes({required String plateNumber,required String vesselId});
  FutureEither<ViajesModel> getMatchedViajesLinkedWithIndustry({
    required String plateNumber,
    required String industryId,
    required ViajesStatusEnum viajesStatusEnum,
  });
  FutureEither<IndustrySubModel> getIndustriaIndustrywithFuture({required String realIndustryId});
  FutureEither<List<UserModel>> getAllAdmins();
  FutureEither<List<UserModel>> getAllRealIndustraUser({required String industryId});
  FutureEither<VesselModel> getVesselCargoModel({required String vesselId});
  FutureEither<ChoferesModel> getChoferesForViajes({required String nationalId});
}

class TruckRegistrationApis implements TruckRegistrationApisImplements{
  final FirebaseFirestore _firestore;
  TruckRegistrationApis({required FirebaseFirestore firestore}): _firestore = firestore;



  @override
  FutureEitherVoid registerTruckEnteringToPort({
    required ViajesModel viajesModel,
    required IndustrySubModel industrySubModel,
    required ChoferesModel choferesModel,
  })async {
    try{
      await _firestore.runTransaction((Transaction transaction) async {
        transaction.set(
          _firestore.collection(FirebaseConstants.viajesCollection).
          doc(viajesModel.viajesId),
          viajesModel.toMap(),
        );
        transaction.update(
          _firestore.collection(FirebaseConstants.industryGuideCollection).
          doc(industrySubModel.industryId),
          industrySubModel.toMap(),
        );

        transaction.update(
          _firestore.collection(FirebaseConstants.choferesCollection).
          doc(choferesModel.choferNationalId),
          choferesModel.toMap(),
        );
      });
      return const Right(null);
    }on FirebaseException catch(e, stackTrace){
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    }catch (e, stackTrace){
      return Left(Failure(e.toString(), stackTrace));
    }
  }


  @override
  FutureEitherVoid registerTruckLeavingFromPort({required ViajesModel viajesModel, required VesselModel vesselModel,}) async {
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
      });
      return Right(null);
    }on FirebaseException catch(e, stackTrace){
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    }catch (e, stackTrace){
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEitherVoid registerTruckEnteringInIndustry({required ViajesModel viajesModel, required IndustrySubModel industrySubModel,}) async {
    try{
      await _firestore.runTransaction((Transaction transaction) async {
        transaction.update(
          _firestore.collection(FirebaseConstants.viajesCollection).
          doc(viajesModel.viajesId),
          viajesModel.toMap(),
        );
        transaction.update(
          _firestore.collection(FirebaseConstants.industryGuideCollection).
          doc(industrySubModel.industryId),
          industrySubModel.toMap(),
        );
      });
      return Right(null);
    }on FirebaseException catch(e, stackTrace){
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    }catch (e, stackTrace){
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEitherVoid registerTruckUnloadingInIndustry({
    required ViajesModel viajesModel,
    required IndustrySubModel industrySubModel,
    required ChoferesModel choferesModel,

  }) async {
    try{
      await _firestore.runTransaction((Transaction transaction) async {
        transaction.update(
          _firestore.collection(FirebaseConstants.viajesCollection).
          doc(viajesModel.viajesId),
          viajesModel.toMap(),
        );
        transaction.update(
          _firestore.collection(FirebaseConstants.industryGuideCollection).
          doc(industrySubModel.industryId),
          industrySubModel.toMap(),
        );
        transaction.update(
          _firestore.collection(FirebaseConstants.choferesCollection).
          doc(choferesModel.choferNationalId),
          choferesModel.toMap(),
        );
      });
      return Right(null);
    }on FirebaseException catch(e, stackTrace){
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    }catch (e, stackTrace){
      return Left(Failure(e.toString(), stackTrace));
    }
  }


  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getLAllViajesModels(){
    return _firestore.collection(FirebaseConstants.industryGuideCollection).
    snapshots();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getPortEnteringViajesList({required String vesselId}){
    return _firestore.collection(FirebaseConstants.viajesCollection).where('vesselId',isEqualTo: vesselId).
    where('viajesStatusEnum', isEqualTo: ViajesStatusEnum.portEntered.type).
    snapshots();
  }

  // no need to use vessel ID here as this industry id is fectedhed based on vessel ID
  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getPortAllInProgressViajesList({required String industryId}){
    return _firestore.collection(FirebaseConstants.viajesCollection).where("industryId",isEqualTo: industryId).
    where('viajesTypeEnum', isEqualTo: ViajesTypeEnum.inProgress.type).
    snapshots();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllCurrentVesselInProgressViajesList({required String vesselId}){
    return _firestore.collection(FirebaseConstants.viajesCollection).where("vesselId",isEqualTo: vesselId).
    where('viajesTypeEnum', isEqualTo: ViajesTypeEnum.inProgress.type).
    snapshots();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getPortLeavingViajesList({required String vesselId}){
    return _firestore.collection(FirebaseConstants.viajesCollection).where('vesselId',isEqualTo: vesselId).
    where('viajesStatusEnum', isEqualTo: ViajesStatusEnum.portLeft.type).
    snapshots();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getIndustryEnteringViajesList(){
    return _firestore.collection(FirebaseConstants.viajesCollection).
    where('viajesStatusEnum', isEqualTo: ViajesStatusEnum.industryEntered.type).
    snapshots();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllViajesList({required String vesselId}){
    return _firestore.collection(FirebaseConstants.viajesCollection).where('vesselId',isEqualTo: vesselId).
    snapshots();
  }
  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllViajesForIndustryList({required IndustryAndVesselIdsModel industryAndVesselIdsModel}){
    return _firestore.collection(FirebaseConstants.viajesCollection).where('vesselId',isEqualTo: industryAndVesselIdsModel.vesselId).where('industryId',isEqualTo: industryAndVesselIdsModel.industryId).where('viajesTypeEnum', isEqualTo: ViajesTypeEnum.completed.type).
    snapshots();
  }




  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getIndustriaIndustry({required IndustryAndVesselIdsModel industryAndVesselIdsModel}){
    return _firestore.collection(FirebaseConstants.industryGuideCollection).
    where('realIndustryId', isEqualTo: industryAndVesselIdsModel.industryId).where('vesselId',isEqualTo: industryAndVesselIdsModel.vesselId).
    snapshots();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getChoferModelByNationalId({required String nationalId}){
    return _firestore.collection(FirebaseConstants.choferesCollection).
    where('choferNationalId', isEqualTo:nationalId).
    snapshots();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getIndustriaIndustryByIndustryId({required String industryId}){
    return _firestore.collection(FirebaseConstants.industryGuideCollection).
    where('industryId', isEqualTo: industryId).
    snapshots();
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
  FutureEither<ViajesModel> getMatchedViajes({required String plateNumber,required String vesselId})async {
    try{
      final querySnapshot = await _firestore.collection(FirebaseConstants.viajesCollection).where("vesselId",isEqualTo: vesselId).
      where('licensePlate', isEqualTo: plateNumber).
      get();
      if(querySnapshot.docs.length!=0){
        ViajesModel model = ViajesModel.fromMap(querySnapshot.docs.first.data());
        return Right(model);
      }else{
        return Left(Failure('No Truck Found!', StackTrace.fromString('getMatchedViajes')));
      }
    }on FirebaseException catch(e, stackTrace){
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    }catch (e, stackTrace){
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEither<ViajesModel> getMatchedViajesLinkedWithIndustry({
    required String plateNumber,
    required String industryId,
    required ViajesStatusEnum viajesStatusEnum,
  })async {
    try{
      print(viajesStatusEnum.type);
      print(plateNumber);
      print(industryId);
      final querySnapshot = await _firestore.collection(FirebaseConstants.viajesCollection).
      where('licensePlate', isEqualTo: plateNumber).
      where('industryId', isEqualTo: industryId).
      where('viajesStatusEnum', isEqualTo: viajesStatusEnum.type).
      get();
      if(querySnapshot.docs.length!=0){
        ViajesModel model = ViajesModel.fromMap(querySnapshot.docs.first.data());
        return Right(model);
      }else{
        return Left(Failure('No Truck Found!', StackTrace.fromString('getMatchedViajesLinkedWithIndustry')));
      }
    }on FirebaseException catch(e, stackTrace){
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    }catch (e, stackTrace){
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEither<IndustrySubModel> getIndustriaIndustrywithFuture({required String realIndustryId})async{
    try{
      final querySnapshot = await _firestore.collection(FirebaseConstants.industryGuideCollection).
      where('realIndustryId', isEqualTo: realIndustryId).
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
  FutureEither<List<UserModel>> getAllAdmins()async{
    try{
      List<UserModel> userList=[];
      final querySnapshot = await _firestore.collection(FirebaseConstants.userCollection).
      where('accountType', isEqualTo: AccountTypeEnum.administrador.type).
      get();
      for (var doc in querySnapshot.docs) {
        userList.add(UserModel.fromMap(
            doc.data()));
      }
      return Right(userList);
    }on FirebaseException catch(e, stackTrace){
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    }catch (e, stackTrace){
      return Left(Failure(e.toString(), stackTrace));
    }
  }
  @override
  FutureEither<List<UserModel>> getAllRealIndustraUser({required String industryId})async{
    try{
      final querySnapshot = await _firestore.collection(FirebaseConstants.industryGuideCollection).
      where('industryId', isEqualTo: industryId).
      get();
      if(querySnapshot.docs.length!=0){
        IndustrySubModel model = IndustrySubModel.fromMap(querySnapshot.docs.first.data());
        List<UserModel> userList=await getUserModelsFromRealIndustryId(realIndustryId: model.realIndustryId);
        return Right(userList);
      }else{
        return Left(Failure('No Industry Found!', StackTrace.fromString('getIndustriaIndustrywithFuture')));
      }
    }on FirebaseException catch(e, stackTrace){
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    }catch (e, stackTrace){
      return Left(Failure(e.toString(), stackTrace));
    }
  }
  Future<List<UserModel>> getUserModelsFromRealIndustryId({required String realIndustryId})async{
      List<UserModel> userList=[];
      final querySnapshot = await _firestore.collection(FirebaseConstants.userCollection).
      where('industryId', isEqualTo: realIndustryId).
      get();
      for (var doc in querySnapshot.docs) {
        userList.add(UserModel.fromMap(
            doc.data()));
      }
      return userList;
  }



  @override
  FutureEither<VesselModel> getVesselCargoModel({required String vesselId}) async{
    try{
      final querySnapshot = await _firestore.collection(FirebaseConstants.vesselCollection).
      where('vesselId', isEqualTo: vesselId).
      get();
      if(querySnapshot.docs.isNotEmpty){
        VesselModel model = VesselModel.fromMap(querySnapshot.docs.first.data());
        return Right(model);
      }else{
        return Left(Failure('No Vessel Found!', StackTrace.fromString('getVesselCargoModel')));
      }
    }on FirebaseException catch(e, stackTrace){
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    }catch (e, stackTrace){
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEither<ChoferesModel> getChoferesForViajes({required String nationalId}) async{
    try{
      final querySnapshot = await _firestore.collection(FirebaseConstants.choferesCollection).
      where('choferNationalId', isEqualTo: nationalId).
      get();
      if(querySnapshot.docs.isNotEmpty){
        ChoferesModel model = ChoferesModel.fromMap(querySnapshot.docs.first.data());
        return Right(model);
      }else{
        return Left(Failure('No Choferes Found!', StackTrace.fromString('getChoferesForViajes')));
      }
    }on FirebaseException catch(e, stackTrace){
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    }catch (e, stackTrace){
      return Left(Failure(e.toString(), stackTrace));
    }
  }

}