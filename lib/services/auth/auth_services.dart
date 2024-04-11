import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:unimatch/helpers/error_messages.dart';
import 'package:unimatch/helpers/toasts.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance; //instance of FirebaseAuth //instance of user services
  Map<String, String> errorMessages = ErrorMessages().errorMessages; //instance of app error messages 
  final Toasts toast = Toasts(); //instance for Toasts helper class
  FToast fToast = FToast(); //instance for flutter toast class


  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (error) {
      fToast.showToast(
        toastDuration: const Duration(seconds: 3),
        gravity: ToastGravity.TOP,
        child: toast.errorToast(errorMessages[error.code])
      );
      throw Exception(error.code);
    }
  }

  Future<UserCredential> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      fToast.showToast(
        child: toast.successToast("Email registrado com sucesso!"),
        toastDuration: const Duration(seconds: 3),
        gravity: ToastGravity.TOP
        );
      return userCredential;
      } on FirebaseAuthException catch (error) {
        fToast.showToast(
          child: toast.errorToast(ErrorMessages().errorMessages[error.code]),
          toastDuration: const Duration(seconds: 3),
          gravity: ToastGravity.TOP);
        throw Exception(error.code);
      }
  }

  Future<void> signOut() async {
    return await _auth.signOut();
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }
}