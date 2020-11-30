import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:quiz/models/quiz_session.dart';
import 'package:quiz/models/question.dart';
import 'package:quiz/widgets/game_over.dart';

class GameScreen extends StatelessWidget {
  bool _showHint = false;

  void changeHintVisibility() {
    _showHint = !_showHint;
  }

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
      return GameOver();
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
              child: Text(
                answer,
                textScaleFactor: 2.0,
                textAlign: TextAlign.center,
              )));
    });

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            question.caption,
            textScaleFactor: 2.0,
          ),
          ElevatedButton(
            onPressed: () => {changeHintVisibility()},
            child: SizedBox(
                width: double.infinity,
                child: Text(
                  "?",
                  textScaleFactor: 2.0,
                  textAlign: TextAlign.center,
                )),
          ),
          Visibility(
            visible: _showHint,
            child: Text(
              question.hint,
              textScaleFactor: 2.0,
            ),
          ),
          ...answerButtons,
        ],
      ),
    );
  }
}
