class Question {
  String caption;
  List<String> answers;
  String hint;

  int correctAnswerIndex;

  Question({this.caption, this.answers, this.correctAnswerIndex, this.hint});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      caption: json['caption'],
      answers: json['answers'].cast<String>(),
      correctAnswerIndex: json['correct_answer_index'],
      hint: json['hint'],
    );
  }

  bool isCorrectAnswerIndex(int answerIndex) {
    return correctAnswerIndex == answerIndex;
  }
}
