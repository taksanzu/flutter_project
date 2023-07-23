import 'package:find_the_dog_study/game_layout.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Find the Dog!',
      theme: ThemeData(
        primaryColor: GameColors.primary1,
        scaffoldBackgroundColor: GameColors.background,
      ),
      home: const FindTheDogScreen(title: 'Find the Dog!'),
    );
  }
}
