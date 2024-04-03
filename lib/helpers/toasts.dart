import 'package:flutter/material.dart';
import 'package:unimatch/styles/global.dart';

class Toasts  {
  Widget errorToast(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(25.0),
    color: MyColors.unimatchRed,
    ),
    child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
        const Icon(Icons.error),
        const SizedBox(
        width: 12.0,
        ),
        Text(text, softWrap: true),
    ],
    ),
  );
  }
}