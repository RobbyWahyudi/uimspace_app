import 'question_model.dart';

class QuizModel {
  final String id;
  final String title;
  final String description;
  final int durationMinutes;
  final int totalQuestions;
  final List<QuizQuestionModel>? questions;

  const QuizModel({
    required this.id,
    required this.title,
    required this.description,
    required this.durationMinutes,
    required this.totalQuestions,
    this.questions,
  });
}
