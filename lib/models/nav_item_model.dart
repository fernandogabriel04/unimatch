import 'rive_model.dart';

class NavItemModel {
  final String title;
  final RiveModel rive;

  NavItemModel({required this.title, required this.rive});
}

List<NavItemModel> bottomNavItems = [
  NavItemModel(
    title: "Chat",
    rive: RiveModel(
      src: "assets/Icons/chat&home.riv",
      artBoard: "chat",
      stateMachine: "State Machine 1"
    )
  ),
  
  NavItemModel(
    title: "Match",
    rive: RiveModel(
      src: "assets/Icons/heartjump.riv",
      artBoard: "jump",
      stateMachine: "State Jump"

      
    )
  ),
  NavItemModel(
    title: "Profile",
    rive: RiveModel(
      src: "assets/Icons/profile.riv",
      artBoard: "profile",
      stateMachine: "State Machine 1"
    )
  ),
];
