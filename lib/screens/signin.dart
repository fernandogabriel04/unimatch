import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:unimatch/helpers/error_messages.dart';
import 'package:unimatch/helpers/toasts.dart';
import 'package:unimatch/screens/forgot_password.dart';
import 'package:unimatch/screens/register.dart';
import 'package:unimatch/services/auth/auth_services.dart';
import 'package:unimatch/styles/global.dart';
import 'package:unimatch/widgets/uni_button.dart';
import 'package:unimatch/widgets/uni_text_field.dart';

//Turning SignIn State Less Widget into a State Full Widget
class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool startedApp = false; //changes when the user click on the app screen
  bool showLogin = false; //changes when the initial animation ends
  bool startAnimation = false; //changes when the TextFields and button are visible
  bool isLoading = false; //changes when starts loading
  final TextEditingController emailTextFieldController = TextEditingController(); //controller to email text field
  final TextEditingController passTextFieldController = TextEditingController(); //controller to password text field
  Map<String, String> errorMessages = ErrorMessages().errorMessages;
  final Toasts toast = Toasts(); //instance for Toasts helper class
  FToast fToast = FToast(); //instance for flutter toast class

  bool handleShowLogin() {
    //change the "showLogin" property
    setState(() {
      showLogin = true;
    });
    return showLogin;
  }

  bool handleIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
    return isLoading;
  }

  bool handleStartAnimation() {
    //change the "startAnimation" property and returns it
    setState(() {
      startAnimation = true;
    });
    return startAnimation;
  }

  bool handleStartApp() {
    setState(() {
      startedApp = !startedApp;
    });
    return startedApp;
  }

  void login() async {
    handleIsLoading();
    final authService = AuthServices();

    try {
      await authService.signInWithEmailAndPassword(emailTextFieldController.text, passTextFieldController.text);
      handleIsLoading();
    } catch (error) {
      handleIsLoading();
      throw Exception(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.unimatchBlack,
      body: Builder(
        builder: (context) {
          fToast.init(context);
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () => handleStartApp(),
                child: Column(
                  children: [
                    Expanded(
                      child: AnimatedContainer(
                        alignment: startedApp
                            ? Alignment.topCenter
                            : Alignment.bottomCenter,
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
                        onFocusChange: (value) =>
                            handleStartAnimation(), //start the animation when the Widget is focused
                        child: AnimatedOpacity(
                          curve: Curves.linear,
                          opacity: startAnimation ? 1 : 0,
                          duration: const Duration(seconds: 1),
                          child: Column(children: [
                            Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: UniTextField(
                                    hintText: "Email",
                                    controller:
                                        emailTextFieldController) //insert the controller into user text field
                                ),
                            Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: UniTextField(
                                    hintText: "Senha",
                                    controller: passTextFieldController,
                                    hideText: true)),
                            Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(
                                          builder: (context) {
                                            return ForgotPasswordPage();
                                          },

                                        ));
                                      },
                                      child: const Text(
                                        "Esqueceu sua senha?",
                                        style: TextStyle(
                                          color: MyColors.unimatchRed,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        ),
                                    ),
                                  ]
                                ),
                            ),
                            UniButton(
                                btnText: "Entrar",
                                onPress: () =>
                                    login(),
                                isLoading: isLoading,
                                ), //insert the controller in the password text field
                            Padding(
                              padding: const EdgeInsets.only(top: 32),
                              child: RichText(
                                  text: TextSpan(
                                      text: "Ainda não possui uma conta? ",
                                      style: const TextStyle(
                                          color: MyColors.unimatchWhite),
                                      children: [
                                    TextSpan(
                                        text: "Registrar",
                                        style: const TextStyle(
                                            color: MyColors.unimatchRed),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () => Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Register()))),
                                  ])),
                            )
                          ]),
                        ),
                      ),
                    ),
                    Expanded(
                      child: AnimatedContainer(
                        alignment: startedApp
                            ? Alignment.bottomCenter
                            : Alignment.topCenter,
                        curve: Curves.fastOutSlowIn,
                        duration: const Duration(seconds: 1),
                        child: AnimatedOpacity(
                          opacity: startedApp ? 0 : 1,
                          duration: const Duration(milliseconds: 500),
                          child: const Text(
                            "Toque para iniciar",
                            style: TextStyle(
                              color: MyColors.unimatchRed,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
