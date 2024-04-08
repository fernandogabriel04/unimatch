import 'package:flutter/material.dart';
import 'package:unimatch/styles/global.dart';
import 'package:unimatch/widgets/uni_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.unimatchBlack,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              UniProfile(),
              
              SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Victoria Heard'),
                  Text('Antigua'),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.email),
                    SizedBox(width: 10.0),
                    Text('heard.j@gmail.com'),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.phone),
                    SizedBox(width: 10.0),
                    Text('9898712132'),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.web),
                    SizedBox(width: 10.0),
                    Text('www.randomweb.com'),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.settings),
                    SizedBox(width: 10.0),
                    Text('Settings'),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.help),
                    SizedBox(width: 10.0),
                    Text('Help'),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 10.0),
                    Text('Log Out'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
