import 'package:flutter/material.dart';
import 'package:unimatch/styles/global.dart';

class MatchesPage extends StatefulWidget {
  const MatchesPage({super.key});

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: MyColors.unimatchBlack,
      body: Center(child: Text('Matches Page', style: TextStyle(color: MyColors.unimatchWhite))),
    );
  }
}