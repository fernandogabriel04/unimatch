import 'package:flutter/material.dart';
import 'package:unimatch/styles/global.dart';

class UserTile extends StatelessWidget {

  final String text;
  final void Function()? onTap;

  const UserTile({
    super.key,
    required this.text,
    required this.onTap
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            decoration: BoxDecoration(
              color: MyColors.unimatchBlack,
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.person, color: MyColors.unimatchWhite,),
                ),
                Text(text, style: TextStyle(
                  color: MyColors.unimatchWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis
                ),)
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            height: 1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: MyColors.unimatchRed
            ),
          )
        ],
      ),
    );
  }
}