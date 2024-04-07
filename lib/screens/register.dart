import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:unimatch/helpers/error_messages.dart';
import 'package:unimatch/helpers/toasts.dart';
import 'package:unimatch/styles/global.dart';
import 'package:unimatch/widgets/uni_bottom_sheet.dart';
import 'package:unimatch/widgets/uni_button.dart';
import 'package:unimatch/widgets/uni_card.dart';
import 'package:unimatch/widgets/uni_text_field.dart';

//Turning SignIn State Less Widget into a State Full Widget
class Register extends StatefulWidget {

  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  bool startAnimation = false; //changes when the TextFields and button are visible
  bool isLoading = false;

  final TextEditingController nameTextFieldController = TextEditingController(); //controller to user text field
  final TextEditingController emailTextFieldController = TextEditingController(); //controller to email text field
  final TextEditingController passTextFieldController = TextEditingController(); //controller to password text field
  final TextEditingController confirmPassTextFieldController = TextEditingController(); //controller to confirm password text field
  final Toasts toasts = Toasts(); //instance of Toasts Widgets class
  FToast fToast = FToast(); //instance of fToast - flutter toast

  bool handleStartAnimation() { //change the "startAnimation" property and returns it
    setState(() {
      startAnimation = true;
    });
    return startAnimation;
  }

  bool handleIsLoading() { //set the "isLoading" to true or false
    setState(() {
      isLoading = !isLoading;
    });
    return isLoading;
  }

  void registerUser() async {
    //start loading
    handleIsLoading();

    if (passTextFieldController.text != confirmPassTextFieldController.text) {
      fToast.showToast(
        child: toasts.errorToast("Ambas as senhas devem ser iguais."),
        toastDuration: const Duration(seconds: 3),
        gravity: ToastGravity.TOP
      );
      handleIsLoading();
    } else if (!emailTextFieldController.text.contains("@alunos.afya.com.br")) {
      fToast.showToast(
        child: toasts.errorToast("Utilize o email institucional"),
        toastDuration: const Duration(seconds: 3),
        gravity: ToastGravity.TOP
      );
      handleIsLoading();
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailTextFieldController.text, password: passTextFieldController.text);
        fToast.showToast(
          child: toasts.successToast("Email registrado com sucesso!"),
          toastDuration: const Duration(seconds: 3),
          gravity: ToastGravity.TOP
          );
        handleIsLoading();
      } on FirebaseAuthException catch (error) {
        handleIsLoading();
        fToast.showToast(
          child: toasts.errorToast(ErrorMessages().errorMessages[error.code]),
          toastDuration: const Duration(seconds: 3),
          gravity: ToastGravity.TOP);
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    return Scaffold(
      backgroundColor: MyColors.unimatchBlack,
      body: SafeArea(
        child: Builder(
          builder: (context) => 
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Container(
                        alignment: Alignment.topCenter,
                        child: SvgPicture.asset(
                          "./assets/Images/unimatch-logo.svg",
                          width: 386,
                          height: 20,
                          ),
                      ),
                    ),
                  ),
                  Focus(
                    autofocus: true, //auto focus when its visible
                    onFocusChange: (value) => handleStartAnimation(), //start the animation when the Widget is focused
                    child: AnimatedOpacity(
                      curve: Curves.linear,
                      opacity: startAnimation? 1: 0,
                      duration: const Duration(seconds: 1),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: UniTextField(hintText: "Nome", controller: nameTextFieldController) //insert the controller into user text field
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                UniTextField(
                                  hintText: "Email",
                                  controller: emailTextFieldController,
                                ),
                                IconButton(
                                  icon: Icon(Icons.info),
                                  onPressed: () {
                                    showModalBottomSheet<void>( 
                                      context: context,
                                      builder: (BuildContext context) {
                                        return UniBottomSheet(title: "EMAIL INSTITUCIONAL", description: "Sobre o email institucional:", 
                                        items: [
                                          UniCard(title: "Outlook", description: 'Acesse o site "Outlook.com".', link: {"Outlook": "https://outlook.live.com/"},),
                                          UniCard(title: "Campo de email", description: 'Seu email será dado da seguinte forma:', info: " <1° NOME> . <ÚLTIMO NOME>@alunos.afya.com.br ",),
                                          UniCard(title: "Senha", description: 'Sua senha será dada da seguinte forma:', info: " Af#<5 ÚLTIMOS DÍGITOS DO SEU CPF>@2024 ",),
                                        ],);
                                      }
                                        // return AlertDialog(
                                        //   backgroundColor: MyColors.unimatchRed,
                                        //   title: const Text(
                                        //     "Informações sobre o e-mail institucional",
                                        //     style: TextStyle(
                                        //       color: MyColors.unimatchWhite,
                                        //       fontSize: 20,
                                        //       fontWeight: FontWeight.bold,
                                        //     ),
                                        //   ),
                                        //   content: RichText(
                                        //     text: const TextSpan(
                                        //       style: TextStyle(
                                        //         color: Colors.white,
                                        //         fontSize: 14,
                                        //       ),
                                        //       children: [
                                        //         TextSpan(
                                        //           text: "Caso não tenha feito o primeiro acesso ainda, realize o seguinte procedimento:\n\n",
                                        //         ),
                                        //         TextSpan(
                                        //           text: "1. Acesse outlook.com e insira os seguintes dados\n",
                                        //         ),
                                        //         TextSpan(
                                        //           text: "2. Email: ",
                                        //         ),
                                        //         TextSpan(
                                        //           text: "<SeuPrimeiroNome>",
                                        //           style: TextStyle(
                                        //             color: Colors.grey,
                                        //             fontWeight: FontWeight.bold,
                                        //           ),
                                        //         ),
                                        //         TextSpan(
                                        //           text: ".",
                                        //         ),
                                        //         TextSpan(
                                        //           text: "<SeuUltimoSobrenome>",
                                        //           style: TextStyle(
                                        //             color: Colors.grey,
                                        //             fontWeight: FontWeight.bold,
                                        //           ),
                                        //         ),
                                        //         TextSpan(
                                        //           text: "@alunos.afya.com.br\n",
                                        //         ),
                                        //         TextSpan(
                                        //           text: "3. Senha: Af#",
                                        //         ),
                                        //         TextSpan(
                                        //           text: "<5 últimos dígitos do seu CPF>",
                                        //           style: TextStyle(
                                        //             color: Colors.grey,
                                        //             fontWeight: FontWeight.bold,
                                        //           ),
                                        //         ),
                                        //         TextSpan(
                                        //           text: "@2024",
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ),
                                        //   actions: <Widget>[
                                        //     TextButton(
                                        //       onPressed: () {
                                        //         Navigator.of(context).pop();
                                        //       },
                                        //       child: const Text("Fechar", style: TextStyle(color: MyColors.unimatchWhite),),
                                        //     ),
                                        //   ],
                                        // );
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: UniTextField(hintText: "Senha", controller: passTextFieldController, hideText: true)
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: UniTextField(hintText: "Confirmar senha", controller: confirmPassTextFieldController, hideText: true)
                          ),
                          UniButton(btnText: "REGISTRAR", isLoading: isLoading, onPress: () => registerUser()), //insert the controller in the password text field
                          Padding(
                            padding: const EdgeInsets.only(top: 32),
                            child: RichText(text: TextSpan(text: "Já possui uma conta? ", style: const TextStyle(
                              color: MyColors.unimatchWhite
                            ), children: [
                              TextSpan(text: "Fazer login", style: const TextStyle(
                                color: MyColors.unimatchRed
                              ),
                              recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.of(context).pop()),
                            ])),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
