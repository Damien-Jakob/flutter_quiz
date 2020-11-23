import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:quiz/models/quiz_session.dart';
import 'package:quiz/models/question.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz"),
      ),
      body: ChangeNotifierProvider(
        create: (_) => QuizSession(),
        child: Consumer<QuizSession>(
          builder: (consumerContext, session, __) => buildPage(consumerContext),
        ),
      ),
    );
  }

  Widget buildPage(BuildContext context) {
    var session = Provider.of<QuizSession>(context, listen: false);
    if (session.gameOver) {
      return buildGameOver(context, session.score);
    }
    return buildQuestion(context, session.currentQuestion);
  }

  Widget buildQuestion(BuildContext context, Question question) {
    var answerButtons = question.answers.map((answer) {
      return ElevatedButton(
          onPressed: () {
            var session = Provider.of<QuizSession>(context, listen: false);
            if (session.checkAnswer(answer)) {
              session.updateScore();
              session.nextQuestion();
            }
          },
          child: SizedBox(
              width: double.infinity,
              child: Text(answer,
                  textScaleFactor: 2.0, textAlign: TextAlign.center)));
    });

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(question.caption, textScaleFactor: 2.0),
          ...answerButtons,
        ],
      ),
    );
  }

  Widget buildGameOver(BuildContext context, int score) {
    var session = Provider.of<QuizSession>(context, listen: false);
    String scoreText =
        session.score.toString() + " / " + session.questionsCount.toString();

    ElevatedButton returnButton = ElevatedButton(
        onPressed: () {
          session.resetScore();
        },
        child: SizedBox(
            width: double.infinity,
            child: Text("New Game",
                textScaleFactor: 2.0, textAlign: TextAlign.center)));

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(scoreText, textScaleFactor: 2.0),
          returnButton,
        ],
      ),
    );
  }
}
