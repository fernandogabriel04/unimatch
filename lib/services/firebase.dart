import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthService extends ChangeNotifier {
  //instance of firestore
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  Reference firebaseStorageRootReference = FirebaseStorage.instance.ref();
  late String imageUrl;
  late Map<String, dynamic> userData;

  Map<String, dynamic>? getUsers(String cpf) { //get the users in the firestore bd
    final usersRef = _fireStore.collection("users").doc(cpf);
    usersRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        userData = data;
        return {...userData};
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
    final Map<String, dynamic> blankUserData = {"cpf": "", "name": "", "age": "", "userImg": "", "address": ""};
    final userData = getUsers(cpf);
    if (userData != null && userData.isNotEmpty) {
      return true;
    } else {
      postUsers({...blankUserData, "cpf": cpf, "userImg": "/o/user_images%2FblankUser.png?alt=media&token=39cade3b-03f9-4f39-817e-837ce7cf738b"}, cpf);
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
      print(imageUrl);
    } catch(e) {
      rethrow;
    }
  }
}