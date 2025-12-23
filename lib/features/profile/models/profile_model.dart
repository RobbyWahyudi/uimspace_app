class ProfileModel {
  final String id;
  final String name;
  final String email;
  final String? studentId;
  final String? major;
  final String? avatarUrl;
  final String phone;
  final String bio;

  const ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    this.studentId,
    this.major,
    this.avatarUrl,
    required this.phone,
    this.bio = '',
  });

  ProfileModel copyWith({
    String? name,
    String? email,
    String? studentId,
    String? major,
    String? avatarUrl,
    String? phone,
    String? bio,
  }) {
    return ProfileModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      studentId: studentId ?? this.studentId,
      major: major ?? this.major,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      phone: phone ?? this.phone,
      bio: bio ?? this.bio,
    );
  }
}

class LoginHistory {
  final String id;
  final String deviceName;
  final String ipAddress;
  final DateTime loginTime;
  final String location;

  const LoginHistory({
    required this.id,
    required this.deviceName,
    required this.ipAddress,
    required this.loginTime,
    required this.location,
  });
}
