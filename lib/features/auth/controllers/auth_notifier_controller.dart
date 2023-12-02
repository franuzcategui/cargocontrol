import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/auth_models/user_model.dart';

final authNotifierCtr = ChangeNotifierProvider((ref) => AuthNotifierController());
class AuthNotifierController extends ChangeNotifier{


  UserModel? _userModel;
  UserModel? get userModel=> _userModel;
  setUserModelData(UserModel model){
    _userModel = model;
    notifyListeners();
  }

}