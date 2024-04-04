import 'package:rive/rive.dart';

class RiveModel {
  final String src, artBoard, stateMachine;
  late SMIBool? status;

  RiveModel({
    required this.src,
    required this.artBoard,
    required this.stateMachine,
    this.status
  });

  set setStatus(SMIBool state) {
    status = state;
  }
}