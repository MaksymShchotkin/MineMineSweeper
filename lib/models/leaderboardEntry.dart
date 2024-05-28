import 'package:firebase_database/firebase_database.dart';

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
