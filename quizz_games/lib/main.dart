import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizz App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: QuizzPage(),
    );
  }
}

class QuizzPage extends StatefulWidget {
  @override
  _QuizzPageState createState() => _QuizzPageState();
}

class _QuizzPageState extends State<QuizzPage> {
  List<String> answer = ['Cat', 'Dog', 'Pig', 'Tiger', 'Monkey'];
  List<String> usedQuestions = [];
  String currentQuestion = '';
  String currentImage = '';
  String currentAnswer = '';
  List<String> randomAnswers = [];
  List<Color?> buttonColors = [
    Colors.blue[200],
    Colors.orange[200],
    Colors.pink[200],
    Colors.green[200]
  ];
  int score = 0;
  int questionIndex = 0;
  Timer? timer;
  int secondsLeft = 10;
  Random random = Random();
  
  @override
  void initState() {
    super.initState();
    startNextQuestion();
  }

  void startNextQuestion() {
    if (questionIndex >= 5) {
      timer?.cancel();
      showResultDialog();
      return;
    }

    setState(() {
      currentQuestion = getRandomQuestion();
      currentImage = getImageForQuestion(currentQuestion);
      currentAnswer = getAnswerForQuestion(currentQuestion);
      randomAnswers = generateRandomAnswers();
      buttonColors.shuffle();
    });

    startTimer();
  }

  String getRandomQuestion() {
    List unusedQuestions = List.from(answer).where((question) {
      return !usedQuestions.contains(question);
    }).toList();

    Random random = Random();
    return unusedQuestions[random.nextInt(unusedQuestions.length)];
  }

  String getImageForQuestion(String question) {
    return 'images/$question.png';
  }

  String getAnswerForQuestion(String question) {
    int index = answer.indexOf(question);
    if (index >= 0) {
      return answer[index];
    }
    return '';
  }

  void startTimer() {
    timer?.cancel();
    secondsLeft = 10;

    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (secondsLeft > 0) {
          secondsLeft--;
        } else {
          timer.cancel();
          questionIndex++;
          usedQuestions.add(currentQuestion);
          startNextQuestion();
        }
      });
    });
  }

  List<String> generateRandomAnswers() {
    List<String> tempAnswers = List.from(answer);
    tempAnswers.remove(currentAnswer); // Loại bỏ câu trả lời hiện tại khỏi danh sách tạm thời
    tempAnswers.shuffle();
    tempAnswers = tempAnswers.sublist(0, 3); // Lấy 3 câu trả lời ngẫu nhiên từ danh sách tạm thời
    tempAnswers.add(currentAnswer); // Thêm câu trả lời hiện tại vào danh sách cuối cùng
    tempAnswers.shuffle(); // Xáo trộn câu trả lời
    return tempAnswers;
  }

  void checkAnswer(String selectedAnswer) {
    if (selectedAnswer == currentAnswer) {
      score += 10;
    } else {
      score -= 5;
    }

    questionIndex++;
    usedQuestions.add(currentQuestion);
    startNextQuestion();
  }

  void showResultDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Kết quả'),
          content: Text('Điểm số của bạn: $score'),
          actions: [
            ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quizz Game'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Timer: $secondsLeft',
            style: TextStyle(
              fontSize: 40,
              color: Colors.black,
            ),
          ),
          Text(
            'Score: $score',
            style: TextStyle(
              fontSize: 40,
              color: Colors.black,
            ),
          ),
          Image.asset(currentImage, width: 200, height: 200),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10),
              itemCount: 4,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: ElevatedButton(
                  onPressed: () => checkAnswer(randomAnswers[index]),
                  child: Text(
                    randomAnswers[index],
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color?>(
                      buttonColors[index]
                    ),
                    minimumSize:
                    MaterialStateProperty.all<Size>(Size(double.infinity, 60)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
