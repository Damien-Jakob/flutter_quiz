import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/models/question.dart';
import 'package:quiz/models/quiz_session.dart';

class QuizQuestion extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QuizQuestionState();
}

class _QuizQuestionState extends State<QuizQuestion> {
  bool _showHint = false;

  void changeHintVisibility() {
    setState(() {
      _showHint = !_showHint;
    });
  }

  void hideHint() {
    setState(() {
      _showHint = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var session = Provider.of<QuizSession>(context);
    Question question = session.currentQuestion;

    if (question == null) {
      return CircularProgressIndicator();
    }

    var answerButtons = question.answers
        .asMap()
        .map((answerIndex, answer) => MapEntry(
            answerIndex,
            ElevatedButton(
                onPressed: () {
                  if (session.submitAnswer(answerIndex)) {
                    hideHint();
                  }
                },
                child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      answer,
                      textScaleFactor: 2.0,
                      textAlign: TextAlign.center,
                    )))))
        .values
        .toList();

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
            child: Text(
              "?",
              textScaleFactor: 2.0,
              textAlign: TextAlign.center,
            ),
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
