import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:unimatch/helpers/toasts.dart';
import 'package:unimatch/services/auth/auth_services.dart';
import 'package:unimatch/services/chat/chat_services.dart';
import 'package:unimatch/styles/global.dart';
import 'package:unimatch/widgets/uni_text_field.dart';

class ChatPage extends StatelessWidget {
  final String userName;
  final String receiverId;
  final FToast fToast = FToast();
  final Toasts toast = Toasts();

  ChatPage({
    super.key,
    required this.userName,
    required this.receiverId
    });

  final TextEditingController _messageController = TextEditingController(); //messages controller

  final ChatServices _chatServices = ChatServices();
  final AuthServices _authServices = AuthServices();

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatServices.sendMessage(receiverId, _messageController.text);
      _messageController.clear(); //clear the message inside the input
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userName, style: TextStyle(color: MyColors.unimatchWhite),),
        backgroundColor: MyColors.unimatchBlack,
      ),
      backgroundColor: MyColors.unimatchBlack,
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildUserInput()
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderId = _authServices.getCurrentUser()!.uid;
    return StreamBuilder(stream: _chatServices.getMessages(receiverId, senderId), builder: ((context, snapshot) {
      if (snapshot.hasError) {
        Expanded(child: Center(child: Text("Ops, ocorreu um erro ao carregar as mensagens", style: TextStyle(color: MyColors.unimatchWhite),),),);
      }

      if (snapshot.hasData) {  
        return ListView(
          children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      }

      return Center(
        child: CircularProgressIndicator(color: MyColors.unimatchWhite,),
      );

    }));
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data["senderId"] == _authServices.getCurrentUser()!.uid;
    var messageAlignment = isCurrentUser? CrossAxisAlignment.end : CrossAxisAlignment.start;

    return Column(
      crossAxisAlignment: messageAlignment,
      children: [
        Text(data["message"], style: TextStyle(color: MyColors.unimatchWhite),
        ),
      ],
    );
  }

  Widget _buildUserInput() {
    return Row(
      children: [
        Expanded(child: UniTextField(hintText: "send a message", controller: _messageController,)),
        IconButton(icon: Icon(Icons.send_sharp, color: MyColors.unimatchRed,), onPressed: sendMessage,)
      ],
    );
  }
}