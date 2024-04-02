import 'package:flutter/material.dart';
import 'package:unimatch/styles/global.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.unimatchSemiBlack,
      body: Center(child: Text('Profile Page', style: TextStyle(color: MyColors.unimatchWhite)),),
    );
  }
}