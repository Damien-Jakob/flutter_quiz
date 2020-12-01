import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:quiz/models/quiz_session.dart';
import 'package:quiz/widgets/game_over.dart';
import 'package:quiz/widgets/quiz_question.dart';

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
      return GameOver();
    }
    return QuizQuestion();
  }
}
