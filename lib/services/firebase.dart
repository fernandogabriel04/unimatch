import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService extends ChangeNotifier {
  //instance of auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //instance of firestore
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  //users collection reference

  Map<String, dynamic>? getUsers(String cpf) { //get the users in the firestore bd
    final usersRef = _fireStore.collection("users").doc(cpf);
    usersRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {...data};
      },
      onError: (e) => {
        throw e
        }
    );
    return null;
  }

  void postUsers(Map<String, dynamic> data, String cpf) {
    final usersRef = _fireStore.collection("users").doc(cpf);
    usersRef.set(data);
  }

  bool verifyUserExistsOnFirebase(String cpf) {
    final Map<String, dynamic> blankUserData = {"name": "", "age": "", "userImg": "", "address": ""};
    final userData = getUsers(cpf);
    if (userData != null && userData.isNotEmpty) {
      return true;
    } else {
      postUsers(blankUserData, cpf);
      return false;
    }
  }

}