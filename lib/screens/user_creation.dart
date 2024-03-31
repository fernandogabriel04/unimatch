import 'package:flutter/material.dart';
import 'package:unimatch/models/user_data_model.dart';
import 'package:unimatch/services/firebase.dart';
import 'package:unimatch/styles/global.dart';

class UserCreation extends StatefulWidget {
  const UserCreation({super.key});

  @override
  State<UserCreation> createState() => _UserCreationState();
}

class _UserCreationState extends State<UserCreation> {
  AuthService authService = AuthService();
  UserDataModel<dynamic>? userData = UserDataModel<dynamic>();
  @override
  Widget build(BuildContext context) {
    userData = authService.getUsers("11470459418");
    return Scaffold(
      backgroundColor: MyColors.unimatchBlack,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              IconButton(
                onPressed: () async {
                  authService.sendImageToStorage();
                  print(userData!.cpf);
                },
                icon: Icon(Icons.camera_alt),
              ),
            ],
          ),
          ),
      ),
    );
  }
}