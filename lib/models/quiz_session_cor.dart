import 'package:flutter/foundation.dart';
import 'package:quiz/models/question.dart';

class QuizSession with ChangeNotifier {
  var _questions = [
    Question("2 + 2", ["1", "2", "4"], "4", "come on"),
    Question("Meaning of life?", ["God", "42", "Me"], "42", "H2G2"),
    Question("May the Force be with you", ["Star Wars", "Forest Gump", "American Pie"], "Star Wars", "Skywalker"),
  ];

  var _currentQuestionIndex = 0;
  var _score = 0;
  var _hintRequested = false;

  Question get currentQuestion => _currentQuestionIndex >= questionsCount ? null : _questions[_currentQuestionIndex];
  int get questionsCount => _questions.length;
  int get score => _score;
  bool get hintRequested => _hintRequested;

  void nextQuestion() {
    _currentQuestionIndex++;
    _hintRequested = false;
    notifyListeners();
  }

  bool checkAnswer(String answer) {
    var correct = currentQuestion.isCorrectAnswer(answer);
    if (correct) _score++;
    return correct;
  }

  void requestHint() {
    _hintRequested = true;
    notifyListeners();
  }
}
