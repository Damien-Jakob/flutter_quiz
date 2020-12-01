import 'package:flutter/foundation.dart';
import 'package:quiz/models/question.dart';

class QuizSession with ChangeNotifier {
  var _questions = [
    Question("2 + 2", ["1", "2", "4"], "4", "come on"),
    Question("Meaning of life?", ["God", "42", "Me"], "42", "H2G2"),
    Question("May the Force be with you",
        ["Star Wars", "Forest Gump", "American Pie"], "Star Wars", "Skywalker"),
  ];

  int _score = 0;
  var _currentQuestionIndex = 0;

  int get score => _score;
  Question get currentQuestion => _currentQuestionIndex >= questionsCount
      ? null
      : _questions[_currentQuestionIndex];
  int get questionsCount => _questions.length;
  bool get gameOver => _score >= questionsCount;

  void _updateScore() {
    _score++;
    notifyListeners();
  }

  void _nextQuestion() {
    _currentQuestionIndex = (_currentQuestionIndex + 1) % _questions.length;
    notifyListeners();
  }

  bool submitAnswer(String answer) {
    bool isCorrect = checkAnswer(answer);
    if (isCorrect) {
      _updateScore();
      _nextQuestion();
    }
    return isCorrect;
  }

  bool checkAnswer(String answer) {
    return _questions[_currentQuestionIndex].isCorrectAnswer(answer);
  }
}
