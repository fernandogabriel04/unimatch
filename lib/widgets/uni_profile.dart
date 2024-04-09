import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unimatch/services/cloud/cloud_services.dart';
import 'package:unimatch/styles/global.dart';

// ignore: must_be_immutable
class UniProfile extends StatelessWidget {
  UniProfile({super.key});

  CloudServices cloudServices = CloudServices();

  Uint8List? _image;

  void selectImage() async{
    Uint8List img = await cloudServices.pickImage(ImageSource.gallery);
    _image = img;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: MyColors.unimatchRed.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: _image != null ?
            CircleAvatar(
                radius: 64,
                backgroundColor: MyColors.unimatchSemiBlack,
                backgroundImage: MemoryImage(_image!),
            )
            : const CircleAvatar(
              radius: 64,
              backgroundImage: AssetImage('assets/Icons/ProfileIcon.png'),
              backgroundColor: MyColors.unimatchSemiBlack,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: IconButton(
              onPressed: selectImage,
              icon: Icon(Icons.photo_camera_rounded, size: 30, color: MyColors.unimatchWhite.withOpacity(0.8),),
            ),
          ),
        ],
      ),
    );
  }
}
