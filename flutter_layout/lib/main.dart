import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key ? key }): super(key: key);

  @override
 MyHomePage createState() => MyHomePage();

}
class MyHomePage extends State<MyApp> {
  String light = 'GREEN';
  String instruction = 'GO';
  Color? instructionColor = Colors.green[500];
  String btnText = 'Start';
  int counter = 10;
  String man = 'RED';
  Timer? _timer;

  void startTimer(){
    counter = 10;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if(counter > 0){
          counter--;
          if(counter == 0){
            changeLight();
          }
        }
      });
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  @override
  void initState(){
    light = 'GREEN';
    instruction = 'GO';
    instructionColor = Colors.green[500];
    super.initState();
  }

  void startLight(){
   setState(() {
     if(btnText == 'Start'){
       btnText = 'Stop';
       startTimer();
     }else{
       btnText = 'Start';
       stopTimer();
     }
   });
  }

  void changeLight(){
    setState(() {
      if(light == 'GREEN'){
        light = 'YELLOW';
        instruction = 'SLOW';
        instructionColor = Colors.yellow[500];
        man = 'RED';
        counter = 3;
      }else if(light == 'YELLOW'){
        light = 'RED';
        instruction = 'STOP';
        instructionColor = Colors.red[500];
        man = 'GREEN';
        counter = 15;
      }else if(light == 'RED'){
        light = 'GREEN';
        instruction = 'GO';
        instructionColor = Colors.green[500];
        man = 'RED';
        counter = 10;
      }
    });
  }
  int turnOnLight(String lightActive){
    int num = 100;
    if(light == lightActive){
      num = 500;
    }
    return num;
  }
  int turnOnLightMan(String lightActive){
    int num = 100;
    if(man == lightActive){
      num = 500;
    }
    return num;
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Flutter layout',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Traffic light'),
          backgroundColor: Colors.pinkAccent,
        ),
        body: Center(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Text(
               instruction,
               style: TextStyle(
                 fontSize: 32,
                 color: instructionColor
               ),
             ),
             Text(
               counter.toString(),
               style: TextStyle(
                 fontSize: 32,
                 color: instructionColor
               ),
             ),
            Container(
              width: 200,
              height: 300,
              color: Colors.black,
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.circle,
                    size: 100,
                    color: Colors.green[turnOnLight('GREEN')],
                  ),
                  Icon(
                    Icons.circle,
                    size: 100,
                    color: Colors.yellow[turnOnLight('YELLOW')],
                  ),
                  Icon(
                    Icons.circle,
                    size: 100,
                    color: Colors.red[turnOnLight('RED')],
                  ),
                ],
              ),
            ),
             Spacer(),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Icon(
                   Icons.accessible_forward,
                   size: 100,
                   color: Colors.green[turnOnLightMan('GREEN')],
                 ),
                 Icon(
                   Icons.accessible,
                   size: 100,
                   color: Colors.red[turnOnLightMan('RED')],
                 ),
               ],
             ),
             Spacer(),
             ElevatedButton(onPressed: startLight, child: Text(btnText, style: TextStyle(fontSize: 20,)),)
           ],
         ),
        ),
      ),
    );
  }


}


