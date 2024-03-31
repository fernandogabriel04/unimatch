import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unimatch/models/user_data_model.dart';

class AuthService extends ChangeNotifier {
  //instance of firestore
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  Reference firebaseStorageRootReference = FirebaseStorage.instance.ref();
  late String imageUrl;
  UserDataModel<dynamic>? userData;

  UserDataModel<dynamic>? getUsers(String cpf) { //get the users in the firestore bd
  final usersRef = _fireStore.collection("users").doc(cpf);
  usersRef.get().then(
    (DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>?;
      if (data == null) return null;
      return userData = UserDataModel<dynamic>.fromMap(data);
    },
    onError: (e) => {
      throw e
      }
    );
    return userData;
  }

  void postUsers(UserDataModel<dynamic> data, String cpf) {
    final usersRef = _fireStore.collection("users").doc(cpf);
    usersRef.set(data.toMap());
  }

  bool verifyUserExistsOnFirebase(String cpf) {
    final Map<String, dynamic> blankUserDataModel = {"cpf": cpf, "name": "", "age": "", "userImg": "${dotenv.env["DATABASE_URL"]}/o/user_images%2FblankUser.png?alt=media&token=${dotenv.env["TOKEN"]}", "address": ""};

    final UserDataModel<dynamic> blankUserData = UserDataModel<dynamic>.fromMap(blankUserDataModel);

    userData = getUsers(cpf);

    print("${userData!.toMap()} ------ SOU EU");

    if (userData != null) {
      return true;
    } else {
      postUsers(blankUserData, cpf);
      return false;
    }
  }

  void sendImageToStorage() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

    if (file==null) return;
    
    final Reference referenceFirebaseDirImages = firebaseStorageRootReference.child("user_images");

    String uniqueFileName = "${DateTime.now().millisecondsSinceEpoch.toString()}${file.name}";

    Reference referenceImageToUpload = referenceFirebaseDirImages.child(uniqueFileName);
    try {
      await referenceImageToUpload.putFile(File(file.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
    } catch(e) {
      rethrow;
    }
  }
}