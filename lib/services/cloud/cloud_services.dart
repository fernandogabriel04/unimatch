import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:unimatch/services/auth/auth_services.dart';


final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final AuthServices _authServices = AuthServices();

class CloudServices{
  pickImage(ImageSource source) async{
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);
    if(file != null){
      return await file.readAsBytes();
    }
    print('No Images Selected');
  }

  Future<String> uploadImageToStorage(String childName, Uint8List file) async{
  Reference ref = _storage.ref().child('user_images/$childName');

  UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> saveImage(Uint8List file) async {
    User? currentUser = _authServices.getCurrentUser();
    try{
      String imageUrl = await uploadImageToStorage('ProfileImage - ${Timestamp.now().microsecondsSinceEpoch}', file);
      await currentUser!.updatePhotoURL(imageUrl);
      return imageUrl;
    } catch(err){
      throw Exception(err);
    }
  }
}
