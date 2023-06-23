import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key ? key }): super(key: key);

  @override
  _MyAppState  createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  String text = '';
  String image = 'images/dice1.png';
  String image2 = 'images/dice1.png';
  @override
  void initState(){
    text = 'initState: Hello World';
    super.initState();
  }
  void btnTapped(){
    setState(() {
      int randomNumber = Random().nextInt(5);
      int randomNumber2 = Random().nextInt(5);
      if(randomNumber == 0){
        image = 'images/dice1.png';
      }else if(randomNumber == 1){
        image = 'images/dice2.png';
      }else if(randomNumber == 2){
        image = 'images/dice3.png';
      }else if(randomNumber == 3){
        image = 'images/dice4.png';
      }else if(randomNumber == 4){
        image = 'images/dice5.png';
      }else{
        image = 'images/dice6.png';
      }
      if(randomNumber2 == 0){
        image2 = 'images/dice1.png';
      }else if(randomNumber2 == 1){
        image2 = 'images/dice2.png';
      }else if(randomNumber2 == 2){
        image2 = 'images/dice3.png';
      }else if(randomNumber2 == 3){
        image2 = 'images/dice4.png';
      }else if(randomNumber2 == 4){
        image2 = 'images/dice5.png';
      }else{
        image2 = 'images/dice6.png';
      }
    });
  }
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Hello World App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello World'),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage('images/diceeLogo.png'),
                  width: 200,
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: Image(image: AssetImage(image)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Image(image: AssetImage(image2)),
                    ),
                  ],
                ),
                Spacer(),
                ElevatedButton(onPressed: btnTapped, child: Text('Tap me'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

