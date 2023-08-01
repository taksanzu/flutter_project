import 'package:flutter/material.dart';
import 'package:gk/screen2.dart';
import 'package:gk/screen3.dart';

class AnimalsApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Animals'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green[300], textStyle: const TextStyle(fontSize: 25, color: Colors.black)),
                child: const Text('Easy'),
                onPressed: () async {
                  Navigator.pushNamed(
                    context,
                    '/screen2',
                    arguments: {
                      'data': 'Easy',
                      'data1': 4,
                      'data2': 150,
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.yellowAccent[400], textStyle: const TextStyle(fontSize: 25, color: Colors.black)),
                child: const Text('Normal'),
                onPressed: () async {
                  Navigator.pushNamed(
                    context,
                    '/screen2',
                    arguments: {
                      'data': 'Normal',
                      'data1': 6,
                      'data2': 100,
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red[600], textStyle: const TextStyle(fontSize: 25, color: Colors.black)),
                child: const Text('Hard'),
                onPressed: () async {
                  Navigator.pushNamed(
                    context,
                    '/screen2',
                    arguments: {
                      'data': 'Hard',
                      'data1': 12,
                      'data2': 50,
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(
      MaterialApp(
        title: 'Animals Game',
        home: AnimalsApp(),
        routes: {
          '/screen2': (context) => Screen2(),
          '/main': (context) => AnimalsApp(),
          '/screen3': (context) => Screen3(),
        },
      ));
}
