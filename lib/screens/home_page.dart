import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unimatch/styles/global.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: MyColors.unimatchBlack,
        child: Center(
          child: SvgPicture.asset(
            "./assets/Images/unimatch-logo.svg",
            height: double.infinity,
            width: double.infinity,
            ),
        ),
      ),
    );
  }
}
