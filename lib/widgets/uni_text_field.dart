import 'package:flutter/material.dart';
import 'package:unimatch/styles/global.dart';

class UniTextField extends StatefulWidget {
  final String hintText;
  final bool isRequired;
  final TextEditingController? controller;

  const UniTextField({
    super.key,
    required this.hintText,
    this.isRequired = false,
    this.controller
    });

  @override
  State<UniTextField> createState() => _UniTextFieldState();
}

class _UniTextFieldState extends State<UniTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: MyColors.unimatchRed,
      onSubmitted: (value) {
        
      },
      controller: widget.controller,
      style: const TextStyle(
        color: MyColors.unimatchWhite
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors.unimatchRed)
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: MyColors.unimatchGray
        )
      )
    );
  }
}