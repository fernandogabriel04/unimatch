import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unimatch/screens/matches_page.dart';
import 'package:unimatch/screens/messages_page.dart';
import 'package:unimatch/screens/profile_page.dart';
import 'package:unimatch/styles/global.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Text('Make a match', style: TextStyle(color: MyColors.unimatchWhite)),
    MatchesPage(),
    MessagesPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: MyColors.unimatchBlack,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: MyColors.unimatchBlack,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Matches',
            backgroundColor: MyColors.unimatchBlack,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
            backgroundColor: MyColors.unimatchBlack,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: MyColors.unimatchBlack,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: MyColors.unimatchRed,
        onTap: _onItemTapped,
      ),
    );
  }
}