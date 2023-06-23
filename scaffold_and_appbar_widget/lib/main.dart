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
              color: Colors.pink,
              fontFamily: 'Sigmar'
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showGeneralDialog(
                context: context,
                pageBuilder: (context, _, __) =>Center(
                  child: Container(
                    height: 620,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.red,
                    ),
                  ),
                ),
            );
          },
          backgroundColor: Colors.red[600],
          child: const Text("click"),
        ),
      ),
    );
  }
}


class test extends StatelessWidget {
  const test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
