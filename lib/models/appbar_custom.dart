import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unimatch/styles/global.dart';

class AppBarCustom extends AppBar{
  AppBarCustom({super.title, super.key}) : super(
    backgroundColor: MyColors.unimatchBlack,
    elevation: 0,
    leading: 
      Builder(
        builder: (context) {
          return InkWell(
            onTap: () {
            Navigator.of(context).pop();
            },
            child: 
              const Icon(Icons.arrow_back_ios_new, color: MyColors.unimatchRed,),
          );
        }
      ),
    centerTitle: true,
  );
}