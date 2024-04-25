import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unimatch/models/appbar_custom.dart';
import 'package:unimatch/styles/global.dart';
import 'package:unimatch/widgets/uni_text_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailTextFieldController = TextEditingController(); //controller to email text field

  @override
  void dispose() {
    emailTextFieldController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailTextFieldController.text.trim());
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text('Link enviado com sucesso! Verifique seu email'),
          );
        }
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        }
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.unimatchSemiBlack,
      appBar: AppBarCustom(
        title: SvgPicture.asset(
          "./assets/Images/unimatch-logo.svg",
          width: 386,
          height: 20,
        ),
      ),
      body: 
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Insira seu email e enviaremos um link para alterar a sua senha',
              textAlign: TextAlign.center, style: TextStyle(color: MyColors.unimatchWhite, fontSize: 16),),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16, top: 16),
            child: UniTextField(
                hintText: "Email",
                controller:
                    emailTextFieldController) //insert the controller into user text field
          ),
          MaterialButton(
            onPressed: passwordReset,
            color: MyColors.unimatchRed,
            child: const Text('Alterar Senha'),
          )
        ],
      ),
    );
  }
}