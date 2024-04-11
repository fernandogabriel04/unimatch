import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unimatch/services/user/user_services.dart';
import 'package:unimatch/styles/global.dart';
import 'package:unimatch/widgets/uni_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => Provider.of<UserServices>(context, listen: false).saveUser());
  }
  
  @override
  Widget build(BuildContext context) {
    if (Provider.of<UserServices>(context).user.isNotEmpty){
                print(Provider.of<UserServices>(context).user.last!.photoURL);
      return Scaffold(
        backgroundColor: MyColors.unimatchBlack,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                UniProfile(photoURL: Provider.of<UserServices>(context).user.last!.photoURL),
                SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(Provider.of<UserServices>(context).user.last!.displayName!, style: const TextStyle(
                      color: MyColors.unimatchWhite
                    ),),
                    Text('Antigua'),
                  ],
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.email),
                      SizedBox(width: 10.0),
                      Text(Provider.of<UserServices>(context).user.last!.email!, style: TextStyle(
                        color: MyColors.unimatchWhite
                      ),),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.phone),
                      SizedBox(width: 10.0),
                      Text(Provider.of<UserServices>(context).user.last!.phoneNumber != null? Provider.of<UserServices>(context).user.last!.phoneNumber! : "Número não cadastrado", style: TextStyle(
                        color: MyColors.unimatchWhite
                      ),),
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
              padding: const EdgeInsets.all(20.0),
              child: const Column(
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
    } return CircularProgressIndicator();
  }
}
