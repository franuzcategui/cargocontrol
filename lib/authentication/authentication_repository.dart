import 'package:cargocontrol/authentication/auth_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInWithEmailAndPasswordFailure implements Exception {
  final String code;
  const SignInWithEmailAndPasswordFailure(this.code);
}

class ForgotPasswordFailure implements Exception {
  final String code;
  const ForgotPasswordFailure(this.code);
}

class SignUpFailure implements Exception {
  final String code;
  const SignUpFailure(this.code);
}

class SignOutFailure implements Exception {}

class AuthenticationRepository {
  final _firebaseAuth = FirebaseAuth.instance;

  Stream<AuthUser> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser == null
          ? AuthUser.empty
          : AuthUser(
              id: firebaseUser.uid,
              email: firebaseUser.email,
              userType: firebaseUser.displayName,
              emailVerified: firebaseUser.emailVerified);
    });
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw SignInWithEmailAndPasswordFailure(e.code);
    }
  }

  Future<void> signUp(
      {required String email,
      required String password,
      required String userType}) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => value.user?.updateDisplayName(userType));
    } on FirebaseAuthException catch (e) {
      throw SignUpFailure(e.code);
    }
  }

  Future<void> forgotPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw ForgotPasswordFailure(e.code);
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw SignOutFailure();
    }
  }
}
