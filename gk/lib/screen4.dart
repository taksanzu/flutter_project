import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RankingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ranking"),
        automaticallyImplyLeading: false,
      ),
      body:
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                _handlePlayAgainButton(context);
              },
              child: Text("Play Again"),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<ScoreEntry>>(
              future: _getRankingData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError || snapshot.data == null) {
                  return Center(child: Text("Error loading data."));
                } else {
                  final rankingData = snapshot.data!;
                  return ListView.builder(
                    itemCount: rankingData.length,
                    itemBuilder: (context, index) {
                      final entry = rankingData[index];
                      return ListTile(
                        title: Text(entry.playerName),
                        subtitle: Text("Score: ${entry.score}, Time: ${entry.playTime} s"),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<List<ScoreEntry>> _getRankingData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> scoreEntries = prefs.getStringList('scoreEntries') ?? [];
    List<ScoreEntry> rankingData = [];
    for (var entry in scoreEntries) {
      List<String> parts = entry.split(':');
      int score = int.parse(parts[0]);
      int playTime = int.parse(parts[1]);
      rankingData.add(ScoreEntry(playerName: "Player", score: score, playTime: playTime));
    }
    return rankingData;
  }
}

void _handlePlayAgainButton (BuildContext context) {
  Navigator.of(context).popUntil((route) => route.isFirst);
}

class ScoreEntry {
  String playerName;
  int score;
  int playTime;

  ScoreEntry({required this.playerName, required this.score, required this.playTime});
}
