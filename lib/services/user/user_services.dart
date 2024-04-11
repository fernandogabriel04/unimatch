import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unimatch/services/auth/auth_services.dart';

class UserServices extends ChangeNotifier {

  AuthServices authServices = AuthServices();

  final List<User?> _user = <User>[];
  UnmodifiableListView<User?> get user => UnmodifiableListView(_user);

  void saveUser(){
    if (_user.isNotEmpty) _user.clear();
    _user.add(authServices.getCurrentUser());
    notifyListeners();
    debugPrint(user.toString());
  }
}