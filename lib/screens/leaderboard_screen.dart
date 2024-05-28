import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class LeaderboardScreen extends StatefulWidget {
  @override
  _LeaderboardScreenState createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  late List<LeaderboardEntry> leaderboardEntries;

  @override
  void initState() {
    super.initState();
    leaderboardEntries = [];
    _fetchLeaderboardData();
  }

  Future<void> _fetchLeaderboardData() async {
    final databaseReference = FirebaseDatabase.instance.ref().child('leaderboard');
    databaseReference.once().then((DatabaseEvent event) {
      final DataSnapshot snapshot = event.snapshot;
      if (snapshot.exists) {
        final List<LeaderboardEntry> loadedEntries = [];
        snapshot.children.forEach((child) {
          final entry = LeaderboardEntry.fromSnapshot(child);
          loadedEntries.add(entry);
        });
        // Sort the loaded entries by score in descending order
        loadedEntries.sort((a, b) => b.score.compareTo(a.score));
        setState(() {
          leaderboardEntries = loadedEntries;
        });
      }
    }).catchError((error) {
      print('Failed to load data: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
      ),
      body: ListView.builder(
        itemCount: leaderboardEntries.length,
        itemBuilder: (context, index) {
          final entry = leaderboardEntries[index];
          return ListTile(
            title: Text(entry.name),
            subtitle: Text(entry.score.toString()),
          );
        },
      ),
    );
  }
}

class LeaderboardEntry {
  final String name;
  final int score;

  LeaderboardEntry({required this.name, required this.score});

  factory LeaderboardEntry.fromSnapshot(DataSnapshot snapshot) {
    final data = snapshot.value as Map<dynamic, dynamic>;
    return LeaderboardEntry(
      name: data['name'] as String,
      score: data['score'] as int,
    );
  }
}
