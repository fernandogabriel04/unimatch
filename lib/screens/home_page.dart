import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unimatch/screens/matches_page.dart';
import 'package:unimatch/screens/messages_page.dart';
import 'package:unimatch/screens/profile_page.dart';
import 'package:unimatch/styles/global.dart';
import 'package:unimatch/widgets/bottom_nav_animated.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    MessagesPage(),
    MatchesPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void logOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.unimatchSemiBlack,
      appBar: AppBar(
        shadowColor: MyColors.unimatchSemiBlack,
        centerTitle: true,
        backgroundColor: MyColors.unimatchBlack,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            color: MyColors.unimatchRed,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('This is a notification')));
            },
          ),
        ],
        title: SvgPicture.asset(
          "./assets/Images/unimatch-logo.svg",
          width: 386,
          height: 20,
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavAnimated(onItemSelected: _onItemTapped, selectedIndex: _selectedIndex,),
    );
  }
}
