import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:unimatch/styles/global.dart';

class UniBottomSheet extends StatelessWidget {
  final String title;
  final List<Widget> texts;

  const UniBottomSheet({
    super.key,
    required this.title,
    required this.texts
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.parse(MediaQuery.of(context).size.height.toString()) / 0.5,
      width: double.parse(MediaQuery.of(context).size.width.toString()),
      decoration: BoxDecoration(
        color: MyColors.unimatchBlack.withOpacity(0.92),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(title, 
              style: const TextStyle(
                color: MyColors.unimatchWhite,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              ),
            ),
            SizedBox(
              height: 320,
              child: ListView.builder(
                itemCount: texts.length,
                itemBuilder: (context, index) {
                  return texts[index];
                }),
            )
          ],
        ),
      ),
    );
  }
}