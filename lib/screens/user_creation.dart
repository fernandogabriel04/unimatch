import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:unimatch/styles/global.dart';

class UserCreation extends StatefulWidget {
  const UserCreation({super.key});

  @override
  State<UserCreation> createState() => _UserCreationState();
}

class _UserCreationState extends State<UserCreation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.unimatchBlack,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Container(),
          ),
      ),
    );
  }
}