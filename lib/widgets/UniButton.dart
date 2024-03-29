import 'package:flutter/material.dart';
import 'package:unimatch/styles/global.dart';

class UniButton extends StatefulWidget {

  final String btnText;

  const UniButton({
    super.key,
    required this.btnText
    });

  @override
  State<UniButton> createState() => _UniButtonState();
}

class _UniButtonState extends State<UniButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: TextButton(
        onPressed: () {},
        style: ButtonStyle(
          alignment: Alignment.center,
          backgroundColor: MaterialStateColor.resolveWith((states) => MyColors.unimatchRed),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
        ),
        child: Text(
          widget.btnText,
          style: const TextStyle(
            color: MyColors.unimatchWhite
          ),
          ),
      ),
    );
  }
}