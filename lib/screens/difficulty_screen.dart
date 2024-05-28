import 'package:flutter/material.dart';
import 'leaderboard_screen.dart';
import 'minesweeper_screen.dart';

class DifficultyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Difficulty'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MinesweeperScreen(
                      rows: 9,
                      columns: 9,
                      numMines: 10,
                    ),
                  ),
                );
              },
              child: Text('Beginner'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MinesweeperScreen(
                      rows: 16,
                      columns: 16,
                      numMines: 40,
                    ),
                  ),
                );
              },
              child: Text('Intermediate'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MinesweeperScreen(
                      rows: 16,
                      columns: 30,
                      numMines: 99,
                    ),
                  ),
                );
              },
              child: Text('Expert'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LeaderboardScreen()),
                );
              },
              child: Text('View Leaderboard'),
            ),
          ],
        ),
      ),
    );
  }
}
