import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unimatch/styles/global.dart';
import 'package:unimatch/widgets/UniButton.dart';
import 'package:unimatch/widgets/UniTextField.dart';

//Turning HomePage State Less Widget into a State Full Widget
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool screenOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                screenOn = true;
              });
            },
            child: Column(
              children: [
                Expanded(
                  child: AnimatedContainer(
                    alignment: screenOn? Alignment.topCenter: Alignment.bottomCenter,
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                    child: SvgPicture.asset(
                      "./assets/Images/unimatch-logo.svg",
                      width: 386,
                      height: 20,
                      ),
                  ),
                ),
                if (screenOn) const Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: UniTextField(hintText: "CPF")
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: UniTextField(hintText: "SENHA")
                      ),
                      UniButton(btnText: "ENTRAR")
                    ]
                  )
                ),
                Expanded(
                  child: AnimatedContainer(
                    alignment: screenOn? Alignment.bottomCenter: Alignment.topCenter,
                    curve: Curves.fastOutSlowIn,
                    duration: const Duration(milliseconds: 500),
                    child: AnimatedOpacity(
                      opacity: screenOn? 0: 1,
                      duration: const Duration( milliseconds: 500),
                      child: const Text("Click to Start", style: TextStyle(
                        color: MyColors.unimatchRed,
                      ),),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: MyColors.unimatchBlack,
      
    );
  }
}
