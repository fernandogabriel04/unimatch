import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unimatch/styles/global.dart';
import 'package:unimatch/widgets/UniButton.dart';
import 'package:unimatch/widgets/UniTextField.dart';

//Turning SignIn State Less Widget into a State Full Widget
class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  late bool startedApp;
  late bool showLogin;

  @override
  void initState() {
    super.initState();
    startedApp = false;
    showLogin = false;
  }

  void handleShowLogin() {
    setState(() {
      showLogin = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                startedApp = true;
              });
            },
            child: Column(
              children: [
                Expanded(
                  child: AnimatedContainer(
                    alignment: startedApp? Alignment.topCenter: Alignment.bottomCenter,
                    duration: const Duration(seconds: 1),
                    onEnd: () => handleShowLogin(),
                    curve: Curves.fastOutSlowIn,
                    child: SvgPicture.asset(
                      "./assets/Images/unimatch-logo.svg",
                      width: 386,
                      height: 20,
                      ),
                  ),
                ),
                Visibility(
                  visible: showLogin,
                  child: const Expanded(
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
                ),
                Expanded(
                  child: AnimatedContainer(
                    alignment: startedApp? Alignment.bottomCenter: Alignment.topCenter,
                    curve: Curves.fastOutSlowIn,
                    duration: const Duration(seconds: 1),
                    child: AnimatedOpacity(
                      opacity: startedApp? 0: 1,
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
