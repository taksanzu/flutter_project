import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter For Beginer',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Hello'),
          centerTitle: true,
          backgroundColor: Colors.cyanAccent,
        ),
        body: const Center(
          child: RiveAnimation.network(
            'https://cdn.rive.app/animations/vehicles.riv',
            fit: BoxFit.cover,
          )
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showGeneralDialog(
                context: context,
                pageBuilder: (context, _, __) =>Center(
                  child: Container(
                    height: 620,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: const BoxDecoration(
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
