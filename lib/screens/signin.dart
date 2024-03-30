import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:unimatch/screens/home.dart';
import 'package:unimatch/styles/global.dart';
import 'package:unimatch/widgets/uni_button.dart';
import 'package:unimatch/widgets/uni_text_field.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

//Turning SignIn State Less Widget into a State Full Widget
class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  late bool startedApp = false; //changes when the user click on the app screen
  late bool showLogin = false; //changes when the initial animation ends
  late bool startAnimation = false; //changes when the TextFields and button are visible
  final FocusNode myFocusNode = FocusNode(); //Init the app focus tree
  final TextEditingController userTextFieldController = TextEditingController(); //controller to user text field
  final TextEditingController passTextFieldController = TextEditingController(); //controller to password text field
  FToast fToast = FToast();

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
    ): _showToast("Usuário ou senha inválidos!");
  }

  bool handleStartAnimation() { //change the "startAnimation" property and returns it
    setState(() {
      startAnimation = true;
    });
    return startAnimation;
  }

  Future<void> _launchInBrowserView(Uri url) async { //redirect the user to the following url page
    if (!await launchUrl(url, mode: LaunchMode.inAppBrowserView)) {
      throw Exception('Could not launch $url');
    }
  }

  _showToast(String text) { //function to show toast on the page
    Widget signinToast = Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: MyColors.unimatchRed,
        ),
        child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
            const Icon(Icons.error),
            const SizedBox(
            width: 12.0,
            ),
            Text(text),
        ],
        ),
    );


    fToast.showToast(
        child: signinToast,
        gravity: ToastGravity.TOP,
        toastDuration: const Duration(seconds: 2),
    );
}

  @override
  Widget build(BuildContext context) {
    fToast.init(context);
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
                            child: UniTextField(hintText: "SENHA", controller: passTextFieldController, hideText: true)
                          ),
                          UniButton(btnText: "ENTRAR", onPress: () => userLogin()), //insert the controller in the password text field
                          Padding(
                            padding: const EdgeInsets.only(top: 32),
                            child: RichText(text: TextSpan(text: "Use as credenciais do site ", style: const TextStyle(
                              color: MyColors.unimatchWhite
                            ), children: [
                              TextSpan(text: "Portal do Aluno", style: const TextStyle(
                                color: MyColors.unimatchRed
                              ),
                              recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                _launchInBrowserView(Uri.parse('https://portalaluno.afya.com.br/web/app/edu/PortalEducacional/login/'));
                              }),
                            ])),
                          )
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
