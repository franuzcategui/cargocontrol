import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseFirebaseService {
  Future<UserCredential> loginUserWithFirebase(String email, String password);
  Future<UserCredential> signupUserwithFireBase(
      String email, String password, String userType);
  void signOutUser();
  bool isUserLoggedIn();
}
