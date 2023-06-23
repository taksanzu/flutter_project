import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wellcome to Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyanAccent),
        useMaterial3: true,
      ),
      home: RandomWord(),
    );
  }
}
class RandomWord extends StatefulWidget{
  const RandomWord({Key? key}) : super(key: key);
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWord> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 20);
  final _saved = <WordPair>{};
  Widget _buildSuggestion(){
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i){
        if (i.isOdd) return const Divider();

        final index = i ~/2;
        if(index >= _suggestions.length){
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }
  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.amber: null,
      ),
      onTap: (){
        setState(() {
          if(alreadySaved){
            _saved.remove(pair);
          }else{
            _saved.add(pair);
          }
        });
      },
    );
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Random Word"),
        actions: [
          IconButton(onPressed: _pushSaved, icon: Icon(Icons.list),)
        ],
      ),
      body: _buildSuggestion(),
    );
  }
  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context){
          final tiles = _saved.map(
              (WordPair pair){
                return ListTile(
                  title: Text(
                    pair.asPascalCase,
                    style: _biggerFont,
                  ),
                );
              }
          );
          final divided = tiles.isNotEmpty
          ? ListTile.divideTiles(tiles: tiles , context: context).toList()
              : <Widget>[];
          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestion'),
            ),
            body: ListView(children: divided,),
          );
        }
      )
    );
  }
}




