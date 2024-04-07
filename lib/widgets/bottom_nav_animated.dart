import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:unimatch/models/nav_item_model.dart';
import 'package:unimatch/styles/global.dart';

class BottomNavAnimated extends StatefulWidget {

  final int selectedNavItem;
  final void Function(int) onItemTapped;

  const BottomNavAnimated({
    super.key,
    required this.selectedNavItem,
    required this.onItemTapped
    });

  @override
  State<BottomNavAnimated> createState() => _BottomNavAnimatedState();
}

class _BottomNavAnimatedState extends State<BottomNavAnimated> {
  List<dynamic> riveIconsInputs = [];
  List<StateMachineController?> controllers = [];


  @override
  void dispose() {
    for (var controller in controllers) {
      controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  int selectedNavItem = widget.selectedNavItem;

    return SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
          decoration: BoxDecoration(
            color: MyColors.unimatchSemiBlack,
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
                  riveIconsInputs[index].change(true);
                  widget.onItemTapped(index);
                  },
                child: SizedBox(
                width: 36,
                height: 36,
                child: Opacity(
                  opacity: selectedNavItem == index? 1: 0.5,
                  child: RiveAnimation.asset(riveIcon.src, artboard: riveIcon.artBoard, fit: BoxFit.cover, onInit: (artboard) {
                    StateMachineController? controller = StateMachineController.fromArtboard(artboard, riveIcon.stateMachine);
                    artboard.addController(controller!);
                    riveIconsInputs.add(controller.findInput<bool>('Pressed'));
                    controllers.add(controller);
                  },),
                ),),
              );
            }
            ),
          ),
        ),
    );
  }
}