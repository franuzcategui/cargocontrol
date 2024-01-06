import 'package:cargocontrol/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final authServiceProvider = ChangeNotifierProvider<AuthService>((_) => AuthService());

class AuthService extends ChangeNotifier{
  AuthService(){
    initAuth();
  }
  late final Box<String> authBox;
  bool _isBoxInitialized = false;
  bool get isReady => _isBoxInitialized;

  Future<String> initAuth() async {
    print('Im tapped');
    if (!_isBoxInitialized) {
      authBox = await Hive.openBox<String>(AppConstants.authBox);
      if (authBox.values.isEmpty) authBox.add('');

      _isBoxInitialized = true;
    }
    return authBox.values.first;
  }

  Future<void> setAuth(String? uid) async => await authBox.put(0, uid ?? '');
  Future<void> removeToken() async => await authBox.clear();

  String? getAuth() => authBox.get(0);
}
