import 'package:flutter/material.dart';
import 'package:love_fortuner/love_number.dart';
import 'package:love_fortuner/love_percent.dart';


class LoveFortuneApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bói tình yêu'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent, textStyle: const TextStyle(fontSize: 15)),
                  child: const Text('Bói theo phần trăm'),
                  onPressed: (){
                    Navigator.push(
                        context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => LovePercent(),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlueAccent, textStyle: const TextStyle(fontSize: 15)),
                  child: const Text('Bói theo số'),
                  onPressed: (){
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => LoveNumber(),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      );
  }
}

void main() {
  runApp(
    MaterialApp(
      title: 'Bói tình yêu',
      home: LoveFortuneApp(),
    ));
}
