import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String userName;
  const ChatPage({
    super.key,
    required this.userName
    });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userName),
      ),
    );
  }
}