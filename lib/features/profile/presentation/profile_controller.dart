import 'package:flutter/material.dart';
import '../models/profile_model.dart';

class ProfileController extends ChangeNotifier {
  ProfileModel _user = const ProfileModel(
    id: '1',
    name: 'Robby Wahyudi',
    email: 'robby.wahyudi@uim.ac.id',
    studentId: '20210801001',
    major: 'Teknik Informatika',
    phone: '+62 821 1234 5678',
    bio: 'Mahasiswa semester 5 yang antusias belajar mobile development.',
  );

  ProfileModel get user => _user;

  final List<LoginHistory> _loginHistory = [
    LoginHistory(
      id: '1',
      deviceName: 'Chrome on Windows 11',
      ipAddress: '192.168.1.1',
      loginTime: DateTime.now().subtract(const Duration(minutes: 5)),
      location: 'Jakarta, Indonesia',
    ),
    LoginHistory(
      id: '2',
      deviceName: 'iPhone 13 Pro',
      ipAddress: '192.168.1.15',
      loginTime: DateTime.now().subtract(const Duration(days: 1)),
      location: 'Jakarta, Indonesia',
    ),
    LoginHistory(
      id: '3',
      deviceName: 'Redmi Note 10',
      ipAddress: '10.0.0.12',
      loginTime: DateTime.now().subtract(const Duration(days: 3)),
      location: 'Bandung, Indonesia',
    ),
  ];

  List<LoginHistory> get loginHistory => _loginHistory;

  void updateProfile(ProfileModel updatedUser) {
    _user = updatedUser;
    notifyListeners();
  }

  void logout() {
    // Logic for logout
    debugPrint('Logging out...');
  }
}
