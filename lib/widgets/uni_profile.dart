import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unimatch/services/cloud/cloud_services.dart'; // Importe a classe StoreData
import 'package:unimatch/styles/global.dart';

class UniProfile extends StatefulWidget {
  UniProfile({Key? key}) : super(key: key);

  @override
  _UniProfileState createState() => _UniProfileState();
}

class _UniProfileState extends State<UniProfile> {
  CloudServices cloudServices = CloudServices();
  StoreData storeData = StoreData();
  String? _imageUrl;

  Uint8List? _image;

  Future<void> selectImage(BuildContext context) async {
    Uint8List img = await cloudServices.pickImage(ImageSource.gallery);
    setState((){
      _image = img;
    });

    if (_image != null) {
      String response = await storeData.saveImage(
        file: _image!,
      );

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response == 'success'
            ? 'Informações salvas com sucesso!'
            : 'Erro ao salvar informações: $response'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
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
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: _image != null
                ? CircleAvatar(
                    radius: 64,
                    backgroundColor: MyColors.unimatchSemiBlack,
                    backgroundImage: NetworkImage(_imageUrl!),
                  )
                : const CircleAvatar(
                    radius: 64,
                    backgroundImage:
                        AssetImage('assets/Icons/ProfileIcon.png'),
                    backgroundColor: MyColors.unimatchSemiBlack,
                  ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: IconButton(
                onPressed: () => selectImage(context),
                icon: Icon(
                  Icons.photo_camera_rounded,
                  size: 30,
                  color: MyColors.unimatchWhite.withOpacity(0.8),
                )),
          ),
        ],
      ),
    );
  }
}
