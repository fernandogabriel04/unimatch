import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';


final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class CloudServices{
  pickImage(ImageSource source) async{
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);
    if(file != null){
      return await file.readAsBytes();
    }
    print('No Images Selected');
  }
}

class StoreData{
Future<String> uploadImageToStorage(String childName, Uint8List file) async{
  Reference ref = _storage.ref().child('user_images/$childName');
  UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
  Future<String> saveImage({
    required Uint8List file,
  }) async {
    String resp = "Some Error Occurred";
    try{
      String imageUrl = await uploadImageToStorage('ProfileImage', file);
      await _firestore.collection('user_images').add({
        'imageLink' : imageUrl,

      });
      resp = 'success';
    }
      catch(err){
        resp = err.toString();
      }
      return resp;
  }
}