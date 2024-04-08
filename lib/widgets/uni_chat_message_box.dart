import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:unimatch/styles/global.dart';

class UniChatMessageBox extends StatelessWidget {
  final bool isCurrentUser;
  final String message;
  final Timestamp timestamp;

  const UniChatMessageBox({
    super.key,
    required this.isCurrentUser,
    required this.message,
    required this.timestamp
    });


  @override
  Widget build(BuildContext context) {
  final date = DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch);
    if (isCurrentUser) {
      return Stack(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 12, left: 12),
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: MyColors.unimatchRed,
              borderRadius: BorderRadius.all(Radius.circular(4))
            ),
            child: Text(message, style: const TextStyle(
              color: MyColors.unimatchWhite,
              fontSize: 16,
              fontWeight: FontWeight.normal
              ),
            ),
          ),
          Positioned(
            bottom: 1,
            right: 3,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: MyColors.unimatchSemiBlack
              ),
              child: Text(("${(date.hour).toString().padLeft(2, "0")}:${(date.minute).toString().padLeft(2, "0")}").toString(), style: const TextStyle(
                color: MyColors.unimatchWhite,
                fontSize: 10
                )),
            ),
          )
        ],
      );
    } else {
      return Stack(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 12, right: 12),
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: MyColors.unimatchSemiBlack,
              borderRadius: BorderRadius.all(Radius.circular(4))
            ),
            child: Text(message, style: const TextStyle(
              color: MyColors.unimatchWhite,
              fontSize: 16,
              fontWeight: FontWeight.normal
              ),
            ),
          ),
          Positioned(
            bottom: 1,
            left: 3,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: MyColors.unimatchRed
              ),
              child: Text(("${(date.hour).toString().padLeft(2, "0")}:${(date.minute).toString().padLeft(2, "0")}").toString(), style: const TextStyle(
                color: MyColors.unimatchWhite,
                fontSize: 10
                )),
            ),
          )
        ],
      );
    }
  }
}