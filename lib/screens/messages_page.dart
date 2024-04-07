import 'package:flutter/material.dart';
import 'package:unimatch/screens/chat_page.dart';
import 'package:unimatch/services/auth/auth_services.dart';
import 'package:unimatch/services/chat/chat_services.dart';
import 'package:unimatch/styles/global.dart';
import 'package:unimatch/widgets/user_tile.dart';

class MessagesPage extends StatelessWidget {
  final ChatServices _chatServices = ChatServices();
  final AuthServices _authServices = AuthServices();
  MessagesPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.unimatchBlack,
      body: _builderUserList(),
    );
  }

  Widget _builderUserList() {
    return StreamBuilder(stream: _chatServices.getUserStream(), builder: (context, snapshot) {
      //error
      if (snapshot.hasError) {
        const Text("Ops, tivemos problemas ao carregar sua lista de usuários");
      }
      //loading
      if (snapshot.hasData) {
        return ListView(
          children: snapshot.data!.map<Widget>((userData) => _buildUserListItem(userData, context)).toList(),
        );
      } else {
        const Center(
          child: CircularProgressIndicator(
            color: MyColors.unimatchWhite,
            strokeWidth: 1,
          ),
        );
      }
      return SizedBox();
    });
  }

  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    //display all users except current user
    if (_authServices.getCurrentUser() != null && userData["email"] != _authServices.getCurrentUser()!.email) {
      return UserTile(text: userData["name"], onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(userName: userData["name"], receiverId: userData["uid"],)));
      },);
    } else {
      return SizedBox();
    }
  }
}