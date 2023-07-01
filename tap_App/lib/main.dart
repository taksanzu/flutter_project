import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyApp> {
  int score = 0;
  int tapCount = 0;
  bool isGameStarted = false;
  Timer? timer;
  int secondsLeft = 10;
  int hearts = 0;

  void startGame() {
    setState(() {
      isGameStarted = true;
      tapCount = 0;
      score = 0;
      hearts = 0;
      secondsLeft = 10;
      timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
        setState(() {
          secondsLeft--;
          if (secondsLeft <= 0) {
            timer.cancel();
            isGameStarted = false;
            updateScore();
          }
        });
      });
    });
  }

  void onTapButton() {
    if (isGameStarted) {
      setState(() {
        tapCount++;
        if (tapCount > 5) {
          hearts = (tapCount - 5) ~/ 2;
          if (hearts > 5) {
            hearts = 5;
          }
        }
        if (tapCount > 12) {
          tapCount = 12;
        }
        calculateScore();
      });
    }
  }

  void updateScore() {
    setState(() {
      score = tapCount - hearts;
    });
  }

  void calculateScore() {
    setState(() {
      if (tapCount > 5) {
        hearts = (tapCount - 5) ~/ 2;
        if (hearts > 5) {
          hearts = 5;
        }
      }
      if (tapCount > 12) {
        tapCount = 12;
      }
      score = tapCount - hearts;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tap game'),
          backgroundColor: Colors.pinkAccent,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Score: $score',
                style: const TextStyle(fontSize: 32, color: Colors.black),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                      (index) => Icon(
                    index < hearts ? Icons.favorite : Icons.favorite_border,
                    size: 50,
                    color: index < 5 - hearts ? Colors.red : Colors.transparent,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Time: $secondsLeft',
                style: const TextStyle(fontSize: 32, color: Colors.black),
              ),
              Text(
                'Tap count: $tapCount',
                style: const TextStyle(fontSize: 32, color: Colors.black),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isGameStarted ? null : startGame,
                child: const Text(
                  'Tap',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
