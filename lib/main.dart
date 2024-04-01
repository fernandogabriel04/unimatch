import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:unimatch/firebase_options.dart';
import 'package:unimatch/screens/home_page.dart';
import 'package:unimatch/screens/signin.dart';
import 'package:unimatch/services/firebase.dart';
import 'package:unimatch/styles/global.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); //verify the current user platform
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: MyColors.unimatchBlack,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: MyColors.unimatchBlack,
        ),
      ),
      title: 'UNIMATCH',
      builder: FToastBuilder(),
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
        create: (context) => AuthService(),
        child: SignIn(),
      ),
    );
  }
}