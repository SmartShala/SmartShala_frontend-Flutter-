import 'package:flutter/material.dart';

/// QuestionData class that holds controllers and variables for all the
/// fields in each question field

class QuestionData {
  static const opts = ['A', 'B', 'C', 'D'];

  String correctAns = 'A';
  TextEditingController question = TextEditingController();
  List<TextEditingController> optControllers =
      opts.map((e) => TextEditingController()).toList();

  void dispose() {
    question.dispose();
    for (TextEditingController c in optControllers) {
      c.dispose();
    }
  }

  Map<String, dynamic> toJson() => {
        /// Get the map or json serializable structure for questions,
        /// options and correct answers
        'question': question.text,
        'opts': optControllers.map((e) => e.text).toList(),
        'correct': correctAns,
      };
}
