import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:unimatch/services/cloud/cloud_services.dart'; 
import 'package:unimatch/services/user/user_services.dart'; 
import 'package:unimatch/styles/global.dart';

// ignore: must_be_immutable
class UniProfile extends StatefulWidget {
  final String? photoURL;

  const UniProfile({
    super.key,
    required this.photoURL
    });

  @override
  UniProfileState createState() => UniProfileState();
}

class UniProfileState extends State<UniProfile> {
  CloudServices cloudServices = CloudServices();

  Uint8List? _image;

  Future<void> updateProfileImage(BuildContext context) async {
    Uint8List img = await cloudServices.pickImage(ImageSource.gallery);
    setState((){
      _image = img;
    });

    if (_image != null) {
      try {
      await cloudServices.saveImage(_image!);
      await cloudServices.deleteImageFromStorage(widget.photoURL!);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Informações salvas com sucesso!'),
      ));
      } catch (err) {
        print(err);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Erro ao salvar informações'),
      ));
      }
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: 
        Stack(
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
              child: widget.photoURL != null ? 
                          CircleAvatar(
                            radius: 64,
                            backgroundColor: MyColors.unimatchSemiBlack,
                            backgroundImage: NetworkImage(widget.photoURL!),
                          ) : 
                          const CircleAvatar(
                            radius: 64,
                            backgroundColor: MyColors.unimatchSemiBlack,
                            backgroundImage: AssetImage("assets/Icons/ProfileIcon.png"),
                          )
              ),
            Positioned(
              bottom: 0,
              right: 0,
              child: IconButton(
                  onPressed: () async { 
                    await updateProfileImage(context);
                    Provider.of<UserServices>(context, listen: false).saveUser();
                    },
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
