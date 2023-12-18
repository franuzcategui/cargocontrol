import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../commons/common_imports/apis_commons.dart';
import '../../../../commons/common_providers/global_providers.dart';
import '../../../../core/constants/firebase_constants.dart';
import '../../../../models/auth_models/user_model.dart';

final databaseApisProvider = Provider<DatabaseApis>((ref) {
  final fireStore = ref.watch(firebaseDatabaseProvider);
  return DatabaseApis(firestore: fireStore);
});

abstract class IDatabaseApis {
  // User Functions
  FutureEitherVoid saveUserInfo({required UserModel userModel});
  Stream<DocumentSnapshot<Map<String, dynamic>>> getCurrentUserStream({required String uid}) ;
  Future<DocumentSnapshot> getCurrentUserInfo({required String uid});
  Stream<UserModel> getUserInfoByUidStream({required String userId});
  FutureEitherVoid updateFirestoreCurrentUserInfo({required UserModel userModel});
}

class DatabaseApis extends IDatabaseApis {
  final FirebaseFirestore _firestore;
  DatabaseApis({required FirebaseFirestore firestore}) : _firestore = firestore;

  @override
  FutureEitherVoid saveUserInfo({required UserModel userModel}) async {
    try {
      await _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userModel.uid)
          .set(userModel.toMap());
      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> getCurrentUserStream({required String uid}) {
    return  _firestore
        .collection(FirebaseConstants.userCollection)
        .doc(uid)
        .snapshots();
  }

  @override
  FutureEitherVoid updateFirestoreCurrentUserInfo({required UserModel userModel}) async {
    try {
      await _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userModel.uid)
          .update(userModel.toMap());
      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }


  @override
  Future<DocumentSnapshot> getCurrentUserInfo({required String uid}) async {
    final DocumentSnapshot document = await _firestore
        .collection(FirebaseConstants.userCollection)
        .doc(uid)
        .get();
    return document;
  }

  @override
  Stream<UserModel> getUserInfoByUidStream({required String userId}) {
    return _firestore.collection(FirebaseConstants.userCollection).doc(userId).snapshots().map(
          (event) => UserModel.fromMap(
        event.data()!,
      ),
    );
  }
}
