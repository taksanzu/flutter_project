import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';


class Screen3 extends StatefulWidget {
  const Screen3({Key? key}) : super(key: key);

  @override
  _Screen3State createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  List<String> animals = [
    "duck",
    "bear",
    "bird",
    "butterfly",
    "cow",
    "fish",
    "goat",
    "hen",
    "kitty",
    "mouse",
    "shiba",
    "turtle"
  ];
  List<String> correctQuestion = [
    "correct",
    "question",
  ];

  int score = 0;
  late int totalTime;
  Timer? timer;
  List<String> gridItems = [];
  List<bool> itemFlipped = [];
  List<int> selectedItemIndices = [];
  bool canTap = true;
  bool initialized = false;
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!initialized) {
      Map<String, dynamic>? arguments =
      ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      totalTime = arguments?['data2'] as int? ?? 0;
      initializeGame();
      initialized = true; // Đặt biến cờ thành true sau khi khởi tạo game
    }
  }

  void initializeGame() {
    gridItems.clear();
    itemFlipped.clear();
    selectedItemIndices.clear();
    gridItems.addAll(animals);
    gridItems.addAll(animals);
    gridItems.shuffle();
    for (int i = 0; i < gridItems.length; i++) {
      itemFlipped.add(false);
    }
    startTimer();
    setState(() {
    });
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        totalTime--;
        if (totalTime <= 0) {
          endGame();
        }
      });
    });
  }

  void endGame() {
    timer?.cancel();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Game Over"),
          content: Text("Your score: $score"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Text("Play Again"),
            ),
          ],
        );
      },
    );
  }
  void checkMatch() {
    if (selectedItemIndices.length == 2) {
      int index1 = selectedItemIndices[0];
      int index2 = selectedItemIndices[1];
      String animalName1 = gridItems[index1];
      String animalName2 = gridItems[index2];

      if (animalName1 == animalName2) {
        setState(() {
          score += 10;
          itemFlipped[index1] = true;
          itemFlipped[index2] = true;
          selectedItemIndices.clear();
        });
        audioPlayer.play(DeviceFileSource('assets/audio/$animalName1.mp3'));
        // Tạo hàm playAudio() để phát âm thanh

      } else {
        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            score -= 5;
            itemFlipped[index1] = false;
            itemFlipped[index2] = false;
            selectedItemIndices.clear();
          });
        });
      }
    }
  }

  void handleItemClick(int index) {
    if (canTap && !itemFlipped[index] && selectedItemIndices.length < 2) {
      setState(() {
        selectedItemIndices.add(index);
        itemFlipped[index] = true;
        checkMatch();
      });
    }
  }

  Widget buildGridItem(int index) {
    String imagePath = itemFlipped[index] ? gridItems[index] : correctQuestion[1];
    return GestureDetector(
      onTap: () => handleItemClick(index),
      child: Card(
        child: Image.asset("assets/images/$imagePath.png"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Memory Game"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Time: $totalTime s"),
            ),
            Expanded(
              child: LimitedBox(
                maxHeight: MediaQuery.of(context).size.height * 0.8,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemCount: gridItems.length,
                  itemBuilder: (context, index) {
                    return buildGridItem(index);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  endGame();
                },
                child: Text("End Game"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
