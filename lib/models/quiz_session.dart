import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:quiz/models/question.dart';
import 'package:http/http.dart' as http;

class QuizSession with ChangeNotifier {
  Question _currentQuestion;
  int _difficulty = 0;
  int _questionsCount = 0;
  int _length = 10;
  int _score = 0;

  Question get currentQuestion => _currentQuestion;
  int get length => _length;
  int get score => _score;
  bool get gameOver => _questionsCount >= _length;

  QuizSession() {
    if (_difficulty >= 2) {
      _length = 15;
    }
    _nextQuestion();
  }

  bool submitAnswer(int answerIndex) {
    bool isCorrect = checkAnswer(answerIndex);
    if (isCorrect) {
      _score++;
    } else if (_difficulty >= 1) {
      _score--;
    }
    if (isCorrect || _difficulty <= 0) {
      _questionsCount++;
      if (!gameOver) {
        _nextQuestion();
      } else {
        notifyListeners();
      }
    }
    return isCorrect;
  }

  bool checkAnswer(int answerIndex) {
    return _currentQuestion.isCorrectAnswerIndex(answerIndex);
  }

  void _updateScore() {
    _score++;
    notifyListeners();
  }

  void _nextQuestion() {
    _currentQuestion = null;
    notifyListeners();
    _fetchNextQuestion();
  }

  void _fetchNextQuestion() async {
    final response = await http.get('http://192.168.1.112:4567/questions/next');

    if (response.statusCode == 200) {
      _currentQuestion = Question.fromJson(jsonDecode(response.body));
      notifyListeners();
    } else {
      throw Exception('Failed to load next question');
    }
  }
}
