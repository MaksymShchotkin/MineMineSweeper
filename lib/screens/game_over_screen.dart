import 'package:flutter/material.dart';
import 'difficulty_screen.dart';
import 'package:firebase_database/firebase_database.dart';

class GameOverScreen extends StatelessWidget {
  final bool isWon;
  final int score;

  GameOverScreen({required this.isWon, required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isWon ? 'You Won!' : 'Game Over'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isWon ? 'Congratulations, you won the game!' : 'Sorry, you clicked on a mine.',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _submitScore(context, score);
              },
              child: Text('Submit Score'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => DifficultyScreen()),
                      (Route<dynamic> route) => false,
                );
              },
              child: Text('Return to Difficulty Selection'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitScore(BuildContext context, int score) {
    String playerName = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Submit Your Score'),
          content: TextField(
            decoration: InputDecoration(labelText: 'Enter your name'),
            onChanged: (value) {
              playerName = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _addToLeaderboard(playerName, score);
                Navigator.of(context).pop();
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void _addToLeaderboard(String playerName, int score) {
    DatabaseReference leaderboardRef = FirebaseDatabase.instance.reference().child('leaderboard');
    leaderboardRef.push().set({'name': playerName, 'score': score});
  }
}
