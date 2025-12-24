class QuizQuestionModel {
  final String id;
  final String text;
  final List<String> options;
  final int correctOptionIndex;

  const QuizQuestionModel({
    required this.id,
    required this.text,
    required this.options,
    required this.correctOptionIndex,
  });
}
