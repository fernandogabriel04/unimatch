import 'package:flutter/material.dart';
import 'package:unimatch/styles/global.dart';

class UniButton extends StatefulWidget {

  final String btnText; //Changes the button text
  final void Function() onPress; //onPress function as a parameter
  final bool isLoading;

  const UniButton({
    super.key,
    required this.btnText,
    required this.onPress,
    this.isLoading = false
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
        onPressed: widget.onPress, //Receive the onPress function
        style: ButtonStyle(
          alignment: Alignment.center,
          backgroundColor: widget.isLoading? MaterialStateColor.resolveWith((states) => const Color.fromARGB(255, 192, 0, 67)) : MaterialStateColor.resolveWith((states) => MyColors.unimatchRed),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
        ),
        child: widget.isLoading? 
          const Center(
            widthFactor: 8,
            child: CircularProgressIndicator(
              color: MyColors.unimatchWhite,
              strokeWidth: 1,
            ),
          )
         : 
          Text(
          widget.btnText,
          style: const TextStyle(
            color: MyColors.unimatchWhite
          ),
          ),
      ),
    );
  }
}