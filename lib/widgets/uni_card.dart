import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:unimatch/styles/global.dart';
import 'package:url_launcher/url_launcher.dart';

class UniCard extends StatelessWidget {
  final String title;
  final String description;
  final String? info;
  final Map<String, String>? link;

  const UniCard({
    super.key,
    required this.title,
    required this.description,
    this.info = "",
    this.link
    });

  Future<void> _launchInBrowserView(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppBrowserView)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          color: MyColors.unimatchBlack,
          border: Border.all(width: 2, color: MyColors.unimatchGray),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: MyColors.unimatchBlack, offset: Offset(0, 1), blurRadius: 5)]
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(
                        color: MyColors.unimatchWhite,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(description, style: TextStyle(
                        color: MyColors.unimatchWhite,
                        fontSize: 14,
                        fontWeight: FontWeight.normal
                        ),
                        ),
                    ],
                  ),
                ],
              ),
              if (info != null) Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: MyColors.unimatchGray
                ),
                child: Text(info!, style: TextStyle(
                  color: MyColors.unimatchWhite,
                  fontSize: 12,
                  fontWeight: FontWeight.bold
                ),),
              ),
              if (link != null) Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: Text(link!.keys.first, style: TextStyle(
                      color: MyColors.unimatchRed,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                      ),),
                    onTap: () => _launchInBrowserView(Uri.parse(link!.values.first)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(Icons.link_outlined, color: MyColors.unimatchRed,),
                  )
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}