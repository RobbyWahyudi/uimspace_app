enum AssignmentType { assignment, quiz }

class AssignmentModel {
  final String id;
  final String title;
  final AssignmentType type;
  final DateTime deadline;
  final String? description;
  final bool isSubmitted;
  final DateTime? submissionDate;
  final double? grade;
  final String? feedback;
  final String? fileName;

  const AssignmentModel({
    required this.id,
    required this.title,
    required this.type,
    required this.deadline,
    this.description,
    this.isSubmitted = false,
    this.submissionDate,
    this.grade,
    this.feedback,
    this.fileName,
  });

  bool get isGraded => grade != null;
}
