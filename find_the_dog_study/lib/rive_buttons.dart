import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveButtons extends StatefulWidget {
  const RiveButtons(
      {Key? key, required this.isReal, required this.stateChangeCb})
      : super(key: key);

  final bool isReal;
  final void Function(String stateMachineName, String stateName) stateChangeCb;

  @override
  State<RiveButtons> createState() => _RiveButtonState();
}

class _RiveButtonState extends State<RiveButtons>{
  void _onRiveInit(Artboard board) {
    var smController = StateMachineController.fromArtboard(
      board,
      "ButtonMachine",
      onStateChange: widget.stateChangeCb,
    ) as StateMachineController;
    board.addController(smController);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: GestureDetector(
        child: RiveAnimation.asset(
          'assets/findthedog.riv',
          artboard: widget.isReal ? "Dog" : "Cat",
          stateMachines: const ["ButtonMachine"],
          onInit: _onRiveInit,
        ),
      ),
    );
  }
}