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
          builder: (consumerContext, session, __) {
            return session.currentQuestion == null ? buildGameEnded(consumerContext, session) : buildQuestion(consumerContext, session);
          },
        ),
      ),
    );
  }

  Widget buildQuestion(BuildContext context, QuizSession session) {
    var question = session.currentQuestion;
    var answerButtons = question.answers.map((answer) {
      return ElevatedButton(
        onPressed: () {
          session.checkAnswer(answer);
          session.nextQuestion();
        },
        child: SizedBox(
          width: double.infinity,
          child: Text(answer, textScaleFactor: 2.0, textAlign: TextAlign.center)
        )
      );
    });

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildHint(context, session),
          Text(question.caption, textScaleFactor: 2.0),
          ...answerButtons,
        ],
      ),
    );
  }

  Widget buildHint(BuildContext context, QuizSession session) {
    if (session.hintRequested) {
      return Text(session.currentQuestion.hint, textScaleFactor: 2.0);
    }
    else {
      return ElevatedButton(
        onPressed: () {
          session.requestHint();
        },
        child: Text("?", textScaleFactor: 2.0, textAlign: TextAlign.center),
      );
    }
  }

  Widget buildGameEnded(BuildContext context, QuizSession session) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("GAME OVER", textScaleFactor: 2.0),
          Text("${session.score} / ${session.questionsCount}", textScaleFactor: 2.0),
          ElevatedButton(
            onPressed: () {
              // This is currently a cheating hack because we know we are the home screen!
              Navigator.pushReplacementNamed(context, "/");
            },
            child: Text("Restart", textScaleFactor: 2.0, textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}
