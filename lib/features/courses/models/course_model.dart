import 'package:flutter/material.dart';

/// Model untuk mata kuliah yang diambil
class Course {
  final String id;
  final String name;
  final String code;
  final String? description;
  final String? instructor;
  final int completedModules;
  final int totalModules;
  final double? grade;
  final Color? accentColor;
  final int credits;
  final String? semester;
  final DateTime? lastAccessed;

  const Course({
    required this.id,
    required this.name,
    required this.code,
    this.description,
    this.instructor,
    required this.completedModules,
    required this.totalModules,
    this.grade,
    this.accentColor,
    this.credits = 3,
    this.semester,
    this.lastAccessed,
  });

  /// Progress percentage (0.0 - 1.0)
  double get progressPercentage =>
      totalModules > 0 ? completedModules / totalModules : 0;

  /// Progress percentage as int (0 - 100)
  int get progressPercent => (progressPercentage * 100).toInt();

  /// Check if course is completed
  bool get isCompleted => completedModules >= totalModules;

  /// Get status text based on progress
  String get statusText {
    if (isCompleted) return 'Selesai';
    if (progressPercentage >= 0.75) return 'Hampir Selesai';
    if (progressPercentage >= 0.5) return 'Sedang Berjalan';
    if (progressPercentage >= 0.25) return 'Baru Dimulai';
    return 'Belum Dimulai';
  }
}

/// Enum untuk filter kelas
enum CourseFilter { all, inProgress, completed }

extension CourseFilterExtension on CourseFilter {
  String get label => switch (this) {
    CourseFilter.all => 'Semua',
    CourseFilter.inProgress => 'Sedang Berjalan',
    CourseFilter.completed => 'Selesai',
  };
}

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

/// Kept for transition from old course feature
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
