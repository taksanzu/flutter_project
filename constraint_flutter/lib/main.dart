import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final player = AudioPlayer();
  final List<Color> buttonColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.pink
  ];
  final List<String> buttonLabels = ['Do', 'Re', 'Mi', 'Fa', 'Sol', 'La','Si'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xylophone',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Xylophone'),
          backgroundColor: Colors.teal[300],
        ),
        body: Center(
          child: Column(
            children: List.generate(
              buttonLabels.length,
                  (index) => Expanded(
                child: ConstrainedBox(
                  constraints: BoxConstraints.expand(),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: ElevatedButton(
                      onPressed: () => btnTapped(index),
                      child: Text(buttonLabels[index]),
                      style: TextButton.styleFrom(
                        minimumSize: Size(800, 400),
                        backgroundColor: buttonColors[index],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void btnTapped(int index) async {
    await player.play(
      DeviceFileSource('assets/audios/note${buttonLabels[index]}.wav'),
    );
  }
}
