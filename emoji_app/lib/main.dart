import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart' as database;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        '/add_emoji': (context) => const AddEditEmojiScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late database.DatabaseReference _databaseReference;
  List<List<String>> emoji = [];

  @override
  void initState() {
    super.initState();
    _databaseReference = database.FirebaseDatabase.instance.reference().child('emojis');
    _databaseReference.onChildAdded.listen(_onEmojiAdded);
    _databaseReference.onChildRemoved.listen(_onEmojiRemoved);
    _databaseReference.onChildChanged.listen(_onEmojiChanged);
  }

  void _onEmojiAdded(database.DatabaseEvent event) {
    setState(() {
      String key = event.snapshot.key!;
      Map<dynamic, dynamic>? snapshotValue = event.snapshot.value as Map<dynamic, dynamic>?;
      if (snapshotValue != null && snapshotValue.containsKey('emoji') && snapshotValue.containsKey('description')) {
        String emojiValue = snapshotValue['emoji'] as String? ?? '';
        String descriptionValue = snapshotValue['description'] as String? ?? '';
        emoji.add([key, emojiValue, descriptionValue]);
      }
    });
  }

  void _onEmojiRemoved(database.DatabaseEvent event) {
    setState(() {
      String key = event.snapshot.key!;
      emoji.removeWhere((e) => e[0] == key);
    });
  }

  void _onEmojiChanged(database.DatabaseEvent event) {
    setState(() {
      String key = event.snapshot.key!;
      Map<dynamic, dynamic>? snapshotValue = event.snapshot.value as Map<dynamic, dynamic>?;
      if (snapshotValue != null && snapshotValue.containsKey('emoji') && snapshotValue.containsKey('description')) {
        String emojiValue = snapshotValue['emoji'] as String? ?? '';
        String descriptionValue = snapshotValue['description'] as String? ?? '';

        for (int i = 0; i < emoji.length; i++) {
          if (emoji[i][0] == key) {
            emoji[i] = [key, emojiValue, descriptionValue];
            break;
          }
        }
      }
    });
  }

  void addEmoji(String newEmoji, String newEmojiDes) {
    _databaseReference.push().set({
      'emoji': newEmoji,
      'description': newEmojiDes,
    });
  }

  void deleteEmoji(int index) {
    String key = emoji[index][0];
    _databaseReference.child(key).remove();
  }

  void editEmoji(int index, String newEmoji, String newEmojiDes) {
    String key = emoji[index][0];
    _databaseReference.child(key).set({
      'emoji': newEmoji,
      'description': newEmojiDes,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emoji App'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: emoji.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text(
                      emoji[index][1],
                      style: const TextStyle(fontSize: 40),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        emoji[index][2],
                        style: const TextStyle(fontSize: 40),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            final result = await Navigator.pushNamed(
                              context,
                              '/add_emoji',
                              arguments: {
                                'data1': emoji[index][1],
                                'data2': emoji[index][2],
                                'data': 'Edit Emoji'
                              },
                            );
                            if (result != null && result is Map) {
                              editEmoji(
                                index,
                                result['emoji'] as String,
                                result['emojiDes'] as String,
                              );
                            }
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            deleteEmoji(index);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(
            context,
            '/add_emoji',
            arguments: {
              'data': 'Add Emoji',
            },
          );
          if (result != null && result is Map) {
            addEmoji(
              result['emoji'] as String,
              result['emojiDes'] as String,
            );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddEditEmojiScreen extends StatelessWidget {
  const AddEditEmojiScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emojiController = TextEditingController();
    final TextEditingController emojiDesController = TextEditingController();
    final Map<String, dynamic>? arguments =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String data = arguments?['data'] as String? ?? '';
    final String data1 = arguments?['data1'] as String? ?? '';
    final String data2 = arguments?['data2'] as String? ?? '';
    emojiController.text = data1;
    emojiDesController.text = data2;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Emoji'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emojiController,
              decoration: const InputDecoration(labelText: 'Emoji'),
            ),
            TextField(
              controller: emojiDesController,
              decoration: const InputDecoration(labelText: 'Emoji Description'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final emoji = emojiController.text;
                final emojiDes = emojiDesController.text;
                Navigator.pop(
                  context,
                  {'emoji': emoji, 'emojiDes': emojiDes},
                );
              },
              child: Text(data),
            ),
          ],
        ),
      ),
    );
  }
}
