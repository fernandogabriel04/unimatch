import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unimatch/services/auth/auth_services.dart';

class UserServices extends ChangeNotifier {

  AuthServices authServices = AuthServices();

  final List<User?> _user = <User>[];
  UnmodifiableListView<User?> get user => UnmodifiableListView(_user);

  void saveUser(){
    User? currentUser = authServices.getCurrentUser();
    if (currentUser == null) notifyListeners();
    if (_user.isNotEmpty) _user.clear();
    _user.add(currentUser);
    notifyListeners();
  }
}