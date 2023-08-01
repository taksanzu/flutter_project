import 'package:flutter/material.dart';


class Screen2 extends StatefulWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2>{

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String levelTitle = arguments?['data'] as String? ?? '';
    final int? animalsTypeTitle = arguments?['data1'] as int?;
    final int? totalTimeTitle = arguments?['data2'] as int?;

    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 2'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                levelTitle,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Animals Type: ' + animalsTypeTitle.toString(),
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Total Time: '+ totalTimeTitle.toString() + ' seconds',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green[300], textStyle: const TextStyle(fontSize: 25, color: Colors.black)),
                child: const Text('Start'),
                onPressed: (){
                  Navigator.pushNamed(
                    context,
                    '/screen3',
                    arguments: {
                      'data': levelTitle,
                      'data1': animalsTypeTitle,
                      'data2': totalTimeTitle,
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