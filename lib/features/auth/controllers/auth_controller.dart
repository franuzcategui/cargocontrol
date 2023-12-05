// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../commons/common_functions/search_tags_handler.dart';
import '../../../commons/common_widgets/show_toast.dart';
import '../../../core/enums/account_type.dart';
import '../../../models/auth_models/user_model.dart';
import '../../../routes/route_manager.dart';
import '../data/auth_apis/auth_apis.dart';
import '../data/auth_apis/database_apis.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    authApis: ref.watch(authApisProvider),
    databaseApis: ref.watch(databaseApisProvider),
  );
});

final userStateStreamProvider = StreamProvider((ref) {
  final authProvider = ref.watch(authControllerProvider.notifier);
  return authProvider.getSigninStatusOfUser();
});

final currentUserAuthProvider = FutureProvider((ref) {
  final authCtr = ref.watch(authControllerProvider.notifier);
  return authCtr.currentUser();
});
final currentUserModelData = FutureProvider((ref) {
  final authCtr = ref.watch(authControllerProvider.notifier);
  return authCtr.getCurrentUserInfo();
});

final fetchUserByIdProvider = StreamProvider.family((ref, String uid) {
  final profileController = ref.watch(authControllerProvider.notifier);
  return profileController.getUserInfoByUid(uid);
});



final currentAuthUserinfoStreamProvider = StreamProvider.family((ref, String uid) {
  final profileController = ref.watch(authControllerProvider.notifier);
  return profileController.getCurrentUserInfoStream(uid: uid);
});


class AuthController extends StateNotifier<bool> {
  final AuthApis _authApis;
  final DatabaseApis _databaseApis;

  AuthController(
      {required AuthApis authApis, required DatabaseApis databaseApis})
      : _authApis = authApis,
        _databaseApis = databaseApis,
        super(false);

  Future<User?> currentUser() async {
    return _authApis.getCurrentUser();
  }

  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
    required AccountTypeEnum accountTypeEnum,
    required BuildContext context,
  }) async {
    state = true;
    final result = await _authApis.registerWithEmailAndPass(
        email: email, password: password);

    result.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) async {
      final searchTags =
      userSearchTagsHandler(email: email, name: '');
      UserModel userModel = UserModel(
          uid: r.uid,
          name: email.split('@')[0],
          email: email,
          createdAt: DateTime.now(),
          accountType: accountTypeEnum,
          fcmToken: '',
          searchTags: searchTags,

      );
      final result2 = await _databaseApis.saveUserInfo(userModel: userModel);
      result2.fold((l) {
        state = false;
        debugPrintStack(stackTrace: l.stackTrace);
        debugPrint(l.message);
        showToast(msg: l.message);
      }, (r) async {
        state = false;
        // Navigator.pushNamed(context, AppRoutes.signInScreen);
        showToast(msg: 'Account Created Successfully!');
      });
    });
  }

  bool hasLastName(String fullName) {
    int num = fullName.split(' ').length;
    return num > 1 ? true : false;
  }


  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final result = await _authApis.signInWithEmailAndPass(
        email: email, password: password);

    result.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) async {
      UserModel userModel = await getCurrentUserInfo();
      userModel.accountType.name == AccountTypeEnum.administrador.name
          ? Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.dashboardScreen, (route) => false)
          : userModel.accountType.name ==
          AccountTypeEnum.industria.name
          ? Navigator.pushNamedAndRemoveUntil(context,
          AppRoutes.dashboardScreen, (route) => false)
          : Navigator.pushNamedAndRemoveUntil(context,
          AppRoutes.dashboardScreen, (route) => false);
      state = false;
    });
  }


  Stream<UserModel> getCurrentUserInfoStream({required String uid}) {
    return _databaseApis.getCurrentUserStream(uid: uid).map((items) {
      UserModel userModel = UserModel.fromMap(items.data()!);
      return userModel;
    });
  }

  Future<UserModel> getCurrentUserInfo() async {
    final userId = _authApis.getCurrentUser();
    final result = await _databaseApis.getCurrentUserInfo(uid: userId!.uid);
    UserModel userModel =
        UserModel.fromMap(result.data() as Map<String, dynamic>);
    return userModel;
  }

  Future<UserModel> getUserInfoByUidFuture(String uid) async {
    final result = await _databaseApis.getCurrentUserInfo(uid: uid);
    UserModel userModel =
        UserModel.fromMap(result.data() as Map<String, dynamic>);
    return userModel;
  }

  Stream<UserModel> getUserInfoByUid(String userId) {
    return _databaseApis.getUserInfoByUidStream(userId: userId);
  }

  // LogOut User
  Future<void> logout({
    required BuildContext context,
  }) async {
    state = true;
    final result = await _authApis.logout();
    result.fold((l) {
      state = false;
      debugPrintStack(stackTrace: l.stackTrace);
      debugPrint(l.message);
      showSnackBar(context, l.message);
    }, (r) {
      state = false;
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.loginScreen, (route) => false);
    });
  }


  // getSigninStatusOfUser
  Stream<User?> getSigninStatusOfUser() {
    return _authApis.getSigninStatusOfUser();
  }
}
