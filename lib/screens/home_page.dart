import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unimatch/styles/global.dart';

//Turning HomePage State Less Widget into a State Full Widget
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {

  bool screenOn = true;
  AlignmentGeometry _alignment = Alignment.center;

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        screenOn = true;
        break;
      case AppLifecycleState.inactive:
        screenOn = false;
        break;
      case AppLifecycleState.paused:
        screenOn = false;
        break;
      case AppLifecycleState.hidden:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this); //Add an observer to the page when the user get into the page
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); //Remove the added observer if its needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (screenOn) {
      _alignment = Alignment.topCenter;
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedContainer(
            alignment: _alignment,
            duration: const Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            child: SvgPicture.asset(
              "./assets/Images/unimatch-logo.svg",
              width: 386,
              height: 20,
              ),
          ),
        ),
      ),
      backgroundColor: MyColors.unimatchBlack,
    );
  }
}
