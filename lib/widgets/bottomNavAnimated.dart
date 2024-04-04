import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:unimatch/models/nav_item_model.dart';
import 'package:unimatch/styles/global.dart';

class BottomNavAnimated extends StatefulWidget {
  const BottomNavAnimated({super.key});

  @override
  State<BottomNavAnimated> createState() => _BottomNavAnimatedState();
}

class _BottomNavAnimatedState extends State<BottomNavAnimated> {
  List<SMITrigger> riveIconsInputs = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
          decoration: BoxDecoration(
            color: MyColors.unimatchBlack,
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: MyColors.unimatchBlack.withOpacity(0.3),
                offset: const Offset(0, 20),
                blurRadius: 20,
              )
            ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(bottomNavItems.length, 
            (index) {
              final riveIcon = bottomNavItems[index].rive;
              return GestureDetector(
                onTap: () {
                  print(riveIcon.stateMachine);
                  riveIconsInputs[index].change(true);
                  },
                child: SizedBox(
                width: 36,
                height: 36,
                child: RiveAnimation.asset(riveIcon.src, artboard: riveIcon.artBoard, onInit: (artboard) {
                  StateMachineController? controller = StateMachineController.fromArtboard(artboard, riveIcon.stateMachine);
                  artboard.addController(controller!);
                  riveIconsInputs.add(controller.findInput<bool>('Pressed') as SMITrigger);
                },),),
              );
            }
            ),
          ),
        ),
    );
  }
}