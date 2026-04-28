import 'package:equatable/equatable.dart';

enum UserType {
  patient,
  doctor,
  pharmacy,
}

class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String phone;
  final UserType userType;
  final String? profileImage;
  final DateTime createdAt;
  final DateTime? lastLogin;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.userType,
    this.profileImage,
    required this.createdAt,
    this.lastLogin,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      userType: UserType.values.firstWhere(
        (e) => e.toString() == json['userType'],
      ),
      profileImage: json['profileImage'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastLogin: json['lastLogin'] != null
          ? DateTime.parse(json['lastLogin'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'userType': userType.toString(),
      'profileImage': profileImage,
      'createdAt': createdAt.toIso8601String(),
      'lastLogin': lastLogin?.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [id, name, email, phone, userType];
}
