import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';



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
  int animalsType = 0;
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
      animalsType = arguments?['data1'] as int? ?? 0;
      initializeGame();
      initialized = true; // Đặt biến cờ thành true sau khi khởi tạo game
    }
  }

  void initializeGame() {
    // Lấy 4 động vật từ danh sách animals
    List<String> selectedAnimals = List.from(animals)..shuffle();
    selectedAnimals = selectedAnimals.take(animalsType).toList();
    // Sao chép danh sách selectedAnimals 3 lần và gộp thành danh sách gridItems
    gridItems.clear();
    if(animalsType == 4){
      for (int i = 0; i < 6; i++) {
        gridItems.addAll(selectedAnimals);
      }
    }else if(animalsType == 6) {
      for (int i = 0; i < 4; i++) {
        gridItems.addAll(selectedAnimals);
      }
    }else if(animalsType == 12) {
      for (int i = 0; i < 2; i++) {
        gridItems.addAll(selectedAnimals);
      }
    }
    itemFlipped.clear();
    selectedItemIndices.clear();
    gridItems.shuffle();

    for (int i = 0; i < gridItems.length; i++) {
      itemFlipped.add(true); // Lật tất cả các hình
    }

    // Tạm dừng trong 5 giây trước khi lật lại
    Future.delayed(const Duration(seconds: 10), () {
      setState(() {
        for (int i = 0; i < gridItems.length; i++) {
          itemFlipped[i] = false; // Lật lại tất cả các hình
        }
        startTimer();
      });
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        totalTime--;
        if (totalTime <= 0) {
          endGame();
        }
      });
    });
  }
  void saveScore(int score, int playTime) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> scoreEntries = prefs.getStringList('scoreEntries') ?? [];
    scoreEntries.add('$score:$playTime');
    prefs.setStringList('scoreEntries', scoreEntries);
  }

  void endGame() {
    timer?.cancel();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Game Over"),
          content: Text("Your score: $score"),
          actions: [
            TextButton(
              onPressed: () {
                saveScore(score, totalTime);
                Navigator.pushNamed(context, '/screen4');
              },
              child: const Text("Wacth Score"),
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

      } else {
        Future.delayed(const Duration(seconds: 2), () {
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
        title: const Text("Memory Game"),
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 8,
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
                child: const Text("End Game"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
