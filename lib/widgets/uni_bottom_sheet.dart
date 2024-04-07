import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:unimatch/styles/global.dart';

class UniBottomSheet extends StatelessWidget {
  final String title;
  final String description;
  final List<Widget> items;

  const UniBottomSheet({
    super.key,
    required this.title,
    required this.description,
    required this.items
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.parse(MediaQuery.of(context).size.height.toString()),
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
              child: Column(
                children: [
                  Center(
                    child: Container(
                      width: 64,
                      height: 4,
                      margin: EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: MyColors.unimatchGray
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(title, 
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        color: MyColors.unimatchWhite,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                    ],
                  ),
                  if (description.isNotEmpty) Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(description, 
                      style: const TextStyle(
                        color: MyColors.unimatchWhite,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 282,
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return items[index];
                }),
            )
          ],
        ),
      ),
    );
  }
}