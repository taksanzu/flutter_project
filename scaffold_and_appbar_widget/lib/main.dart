import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Hello'),
          centerTitle: true,
          backgroundColor: Colors.cyanAccent,
        ),
        body: const Center(
          child: Text(
              "Hello Khang",
            style: TextStyle(
            fontSize: 20.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              color: Colors.green,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {

          },
          child: Text("click"),
          backgroundColor: Colors.red[600],
        ),
      ),
    );
  }
}
