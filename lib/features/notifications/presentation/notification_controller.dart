import 'package:flutter/material.dart';
import '../models/notification_model.dart';

class NotificationController extends ChangeNotifier {
  List<NotificationModel> _notifications = [
    NotificationModel(
      id: '1',
      title: 'Tugas Berhasil Dikumpulkan',
      message:
          'Tugas "Pemrograman Mobile - Pertemuan 10" telah berhasil diunggah.',
      timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
      type: NotificationType.assignmentSubmitted,
      courseName: 'Pemrograman Mobile',
      isRead: false,
    ),
    NotificationModel(
      id: '2',
      title: 'Deadline Mendekat!',
      message:
          'Sisa 2 jam lagi untuk mengumpulkan "Kuis Teori Graf". Segera selesaikan!',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      type: NotificationType.deadlineApproaching,
      courseName: 'Matematika Diskrit',
      isRead: false,
    ),
    NotificationModel(
      id: '3',
      title: 'Pengumuman Dosen',
      message:
          'Pak Budi: Kuliah besok pagi diganti menjadi sesi asinkronus di LMS.',
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      type: NotificationType.announcement,
      courseName: 'Basis Data',
      isRead: true,
    ),
    NotificationModel(
      id: '4',
      title: 'Nilai Baru Tersedia',
      message:
          'Nilai untuk "Proyek Tengah Semester" telah dirilis. Silakan cek hasil Anda.',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      type: NotificationType.gradeUpdate,
      courseName: 'Desain UI/UX',
      isRead: true,
    ),
    NotificationModel(
      id: '5',
      title: 'Deadline Mendekat!',
      message: 'Tugas "Analisis Algoritma" akan berakhir dalam 24 jam.',
      timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
      type: NotificationType.deadlineApproaching,
      courseName: 'Desain & Analisis Algoritma',
      isRead: true,
    ),
  ];

  List<NotificationModel> get notifications => _notifications;

  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  void markAsRead(String id) {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
      notifyListeners();
    }
  }

  void markAllAsRead() {
    _notifications = _notifications
        .map((n) => n.copyWith(isRead: true))
        .toList();
    notifyListeners();
  }

  void clearAll() {
    _notifications = [];
    notifyListeners();
  }
}
