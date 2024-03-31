import 'package:flutter/material.dart';
import 'package:unimatch/services/firebase.dart';
import 'package:unimatch/styles/global.dart';

class UserCreation extends StatefulWidget {
  const UserCreation({super.key});

  @override
  State<UserCreation> createState() => _UserCreationState();
}

class _UserCreationState extends State<UserCreation> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
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
                },
                icon: Icon(Icons.camera_alt),
              )
            ],
          ),
          ),
      ),
    );
  }
}