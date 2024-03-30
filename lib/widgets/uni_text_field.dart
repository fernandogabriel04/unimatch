import 'package:flutter/material.dart';
import 'package:unimatch/styles/global.dart';

class UniTextField extends StatefulWidget {
  final String hintText; //Changes the hintText field
  final bool isRequired; //Verify if the textField is required or not
  final TextEditingController? controller; //Controller to textFields

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
      controller: widget.controller, //Receive the controller as a parameter
      style: const TextStyle(
        color: MyColors.unimatchWhite
      ),
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: MyColors.unimatchRed)
        ),
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          color: MyColors.unimatchGray
        )
      )
    );
  }
}