import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/models/quiz_session.dart';

class GameOver extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var session = Provider.of<QuizSession>(context, listen: false);
    String scoreText = "${session.score} / ${session.length}";

    ElevatedButton newGameButton = ElevatedButton(
        onPressed: () {
          // Cheating way to reset the QuizSession
          Navigator.pushReplacementNamed(context, "/");
        },
        child: SizedBox(
            width: double.infinity,
            child: Text(
              "New Game",
              textScaleFactor: 2.0,
              textAlign: TextAlign.center,
            )));

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            scoreText,
            textScaleFactor: 2.0,
          ),
          newGameButton,
        ],
      ),
    );
  }
}
