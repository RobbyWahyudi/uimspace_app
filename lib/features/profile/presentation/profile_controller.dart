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
    bio: 'Lowkey Programmer',
  );

  ProfileModel get user => _user;

  void updateProfile(ProfileModel updatedUser) {
    _user = updatedUser;
    notifyListeners();
  }

  void logout() {
    // Logic for logout
    debugPrint('Logging out...');
  }
}
