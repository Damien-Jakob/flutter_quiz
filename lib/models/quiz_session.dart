import 'package:flutter/foundation.dart';
import 'package:quiz/models/question.dart';

class QuizSession with ChangeNotifier {
  int _score = 0;

  var _questions = [
    Question("2 + 2", ["1", "2", "4"], "4", "come on"),
    Question("Meaning of life?", ["God", "42", "Me"], "42", "H2G2"),
    Question("May the Force be with you",
        ["Star Wars", "Forest Gump", "American Pie"], "Star Wars", "Skywalker"),
  ];

  var _currentQuestionIndex = 0;

  int get score => _score;

  Question get currentQuestion => _questions[_currentQuestionIndex];

  int get questionsCount => _questions.length;

  bool get gameOver => _score >= questionsCount;

  void resetScore() {
    _score = 0;
    notifyListeners();
  }

  void updateScore() {
    _score++;
    notifyListeners();
  }

  void nextQuestion() {
    _currentQuestionIndex = (_currentQuestionIndex + 1) % _questions.length;
    notifyListeners();
  }

  bool checkAnswer(String answer) {
    return _questions[_currentQuestionIndex].isCorrectAnswer(answer);
  }
}
