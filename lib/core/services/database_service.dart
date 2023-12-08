import 'package:cargocontrol/utils/constants/app_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final authServiceProvider = Provider<AuthService>((_) => AuthService());

class AuthService {
  AuthService(){
    initAuth();
  }
  late final Box<String> authBox;


  Future<String> initAuth() async {
    authBox = await Hive.openBox<String>(AppConstants.authBox);
    if (authBox.values.isEmpty) authBox.add('');
    return authBox.values.first;
  }

  Future<void> setAuth(String? uid) async => await authBox.put(0, uid ?? '');

  String? getAuth() => authBox.get(0);
}
