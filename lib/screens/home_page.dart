import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unimatch/screens/matches_page.dart';
import 'package:unimatch/screens/messages_page.dart';
import 'package:unimatch/screens/profile_page.dart';
import 'package:unimatch/services/auth/auth_services.dart';
import 'package:unimatch/styles/global.dart';
import 'package:unimatch/widgets/bottom_nav_animated.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    MessagesPage(),
    MatchesPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void logOut() async {
    final authServices = AuthServices();
    await authServices.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.unimatchBlack,
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
          IconButton(
            icon: const Icon(Icons.logout),
            color: MyColors.unimatchRed,
            onPressed: () {
              logOut();
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
      bottomNavigationBar: BottomNavAnimated(selectedNavItem: _selectedIndex, onItemTapped: _onItemTapped,)
    );
  }
}