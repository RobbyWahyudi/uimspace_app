import 'package:flutter/material.dart';

enum CourseMaterialType { pdf, url, video, zoom }

class CourseMaterial {
  final String id;
  final String title;
  final CourseMaterialType type;
  final String? url;
  final bool isOpened;

  const CourseMaterial({
    required this.id,
    required this.title,
    required this.type,
    this.url,
    this.isOpened = false,
  });
}

class CourseMeeting {
  final String id;
  final String title;
  final String description;
  final List<CourseMaterial> materials;

  const CourseMeeting({
    required this.id,
    required this.title,
    required this.description,
    required this.materials,
  });
}

enum AssessmentType { assignment, quiz }

class CourseAssessment {
  final String id;
  final String title;
  final AssessmentType type;
  final DateTime deadline;
  final String? description;
  final bool isSubmitted;

  const CourseAssessment({
    required this.id,
    required this.title,
    required this.type,
    required this.deadline,
    this.description,
    this.isSubmitted = false,
  });
}

class CourseProgress {
  final String id;
  final String name;
  final String code;
  final int completedModules;
  final int totalModules;
  final double grade;
  final Color? accentColor;

  const CourseProgress({
    required this.id,
    required this.name,
    required this.code,
    required this.completedModules,
    required this.totalModules,
    this.grade = 0,
    this.accentColor,
  });

  double get progressPercentage =>
      totalModules > 0 ? completedModules / totalModules : 0;
}
