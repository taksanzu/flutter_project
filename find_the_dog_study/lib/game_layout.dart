import 'package:flutter/material.dart';
import 'package:find_the_dog_study/colors.dart';
import 'package:find_the_dog_study/enums.dart';
import 'package:find_the_dog_study/rive_buttons.dart';
import 'package:find_the_dog_study/end_state.dart';
import 'dart:math';

class FindTheDogScreen extends StatefulWidget {
  const FindTheDogScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<FindTheDogScreen> createState() => _FindTheDogScreen();
}

class _FindTheDogScreen extends State<FindTheDogScreen>{
  final _random = Random();
  int guessesLeft = 6;
  bool didLose = false;
  int animationsRunning = 0;

  GameStatus gameState = GameStatus.inProgress;

  int _getDogIdx() {
    return 0 + _random.nextInt(15 - 0);
  }
  void _handleGuessTap(isWrongGuess) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    if (isWrongGuess) {
      setState(() {
        animationsRunning++;
        if (guessesLeft == 1) {
          didLose = true;
          gameState = GameStatus.lost;
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
        }
        if (guessesLeft > 0) {
          guessesLeft--;
        }
      });
    } else {
      setState(() {
        animationsRunning++;
        gameState = GameStatus.won;
      });
    }
  }

  void _handleStateEnter(String stateMachineName, String toStateName) {
    if (toStateName == "Pressed_wrong_static") {
      setState(() {
        animationsRunning--;
      });
    } else if (toStateName == "Pressed_wrong") {
      _handleGuessTap(true);
      var snackBar = SnackBar(
        content: Text(
          "$guessesLeft guess${guessesLeft == 1 ? "" : "es"} left!",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: GameColors.snackbarText,
          ),
        ),
        width: 300.0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: GameColors.snackbarBg,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (toStateName == "Pressed_correct") {
      _handleGuessTap(false);
    } else if (toStateName == "Pressed_correct_static") {
      setState(() {
        animationsRunning--;
      });
    }
  }
  // Render 20 widgets, of which one is the true dog button
  List<Widget> renderButtons() {
    int dogIdx = _getDogIdx();
    List<Widget> list = List.empty(growable: true);
    for (var i = 0; i < 15; i++) {
      bool isReal = i == dogIdx;
      list.add(
        RiveButtons(isReal: isReal, stateChangeCb: _handleStateEnter),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: GameColors.primary1,
      ),
      body: SizedBox.expand(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: gameState == GameStatus.inProgress || animationsRunning >= 1
                ? GameColors.background
                : GameColors.backgroundEndState
          ),
          child: gameState == GameStatus.inProgress || animationsRunning >= 1
            ?GridView.count(
              crossAxisCount: 5,
            children: [...renderButtons()])
          : EndState(gameState: gameState),
        ),
      ),
    );
  }
}