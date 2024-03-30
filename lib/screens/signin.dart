import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:unimatch/screens/home.dart';
import 'package:unimatch/styles/global.dart';
import 'package:unimatch/widgets/uni_button.dart';
import 'package:unimatch/widgets/uni_text_field.dart';
import 'package:http/http.dart' as http;

//Turning SignIn State Less Widget into a State Full Widget
class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  late bool startedApp; //changes when the user click on the app screen
  late bool showLogin; //changes when the initial animation ends
  late bool startAnimation; //changes when the TextFields and button are visible
  final FocusNode myFocusNode = FocusNode(); //Init the app focus tree
  final TextEditingController userTextFieldController = TextEditingController(); //controller to user text field
  final TextEditingController passTextFieldController = TextEditingController(); //controller to password text field

  @override
  void initState() { //init the variables
    super.initState();
    startedApp = false; 
    showLogin = false;
    startAnimation = false;
  }

  void handleShowLogin() { //change the "showLogin" property
    setState(() {
      showLogin = true;
    });
  }

  void userLogin() async {
    var response = await http.post(
      Uri.parse("https://academico.afya.com.br/Corpore.Net//Source/EDU-EDUCACIONAL/Public/EduPortalAlunoLogin.aspx?AutoLoginType=ExternalLogin&redirect=calendario"), 
      body: Uri.encodeFull(
        "User=${userTextFieldController.text}&Pass=${passTextFieldController.text}&Alias=CorporeRM"
        ),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Accept": "application/json"
      },
      encoding: Encoding.getByName('utf-8'),
    );

    response.body.contains("Object moved")? Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Home())
    ): Fluttertoast.showToast(
        msg: "Usuário ou senha inválidos!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: MyColors.unimatchSemiBlack,
        textColor: MyColors.unimatchRed,
        fontSize: 16.0
    );
  }

  bool handleStartAnimation() { //change the "startAnimation" property and returns it
    setState(() {
      startAnimation = true;
    });
    return startAnimation;
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
                  child: Focus(
                    autofocus: true, //auto focus when its visible
                    focusNode: myFocusNode,
                    onFocusChange: (value) => handleStartAnimation(), //start the animation when the Widget is focused
                    child: AnimatedOpacity(
                      curve: Curves.linear,
                      opacity: startAnimation? 1: 0,
                      duration: const Duration(seconds: 1),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: UniTextField(hintText: "CPF", controller: userTextFieldController) //insert the controller into user text field
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: UniTextField(hintText: "SENHA", controller: passTextFieldController,)
                          ),
                          UniButton(btnText: "ENTRAR", onPress: () => userLogin()) //insert the controller in the password text field
                        ]
                      ),
                    ),
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
                      child: const Text("Toque para iniciar", style: TextStyle(
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
