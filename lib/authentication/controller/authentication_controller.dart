// import 'dart:async';
//
// import 'package:cargocontrol/authentication/auth_user.dart';
// import 'package:cargocontrol/authentication/authentication_repository.dart';
// import 'package:cargocontrol/authentication/controller/authentication_state.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// final authRepoProvider = Provider<AuthenticationRepository>(
//   (_) => AuthenticationRepository(),
// );
//
// final authProvider =
//     StateNotifierProvider<AuthControllerNotifier, AuthenticationState>(
//         (ref) => AuthControllerNotifier(ref.watch(authRepoProvider)));
//
// class AuthControllerNotifier extends StateNotifier<AuthenticationState> {
//   final AuthenticationRepository _authRepository;
//   late final StreamSubscription _streamSubscription;
//
//   AuthControllerNotifier(this._authRepository)
//       : super(const AuthenticationState.unauthenticated()) {
//     _streamSubscription =
//         _authRepository.user.listen((user) => _onUserChanged(user));
//   }
//
//   void _onUserChanged(AuthUser user) {
//     if (user.isEmpty) {
//       state = const AuthenticationState.unauthenticated();
//     } else {
//       state = AuthenticationState.authenticated(user);
//     }
//   }
//
//   void onSignOut() {
//     _authRepository.signOut();
//   }
//
//   @override
//   void dispose() {
//     _streamSubscription.cancel();
//     super.dispose();
//   }
// }
