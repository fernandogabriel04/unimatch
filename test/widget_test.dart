import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unimatch/firebase_options.dart';
import 'package:unimatch/services/firebase.dart';

void main() {
  testWidgets('Should print something', (WidgetTester tester) async {

    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    final authService = AuthService();

    authService.verifyUserExistsOnFirebase("11470459418");

  });
}
