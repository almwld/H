import 'package:equatable/equatable.dart';

class DoctorModel extends Equatable {
  final String id;
  final String name;
  final String specialization;
  final String? profileImage;
  final double rating;
  final int reviewCount;
  final int experienceYears;
  final String? bio;
  final String? education;
  final List<String>? languages;
  final bool isAvailable;
  final double consultationFee;
  final double? distance;
  final List<TimeSlot>? availableSlots;

  const DoctorModel({
    required this.id,
    required this.name,
    required this.specialization,
    this.profileImage,
    required this.rating,
    required this.reviewCount,
    required this.experienceYears,
    this.bio,
    this.education,
    this.languages,
    required this.isAvailable,
    required this.consultationFee,
    this.distance,
    this.availableSlots,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'] as String,
      name: json['name'] as String,
      specialization: json['specialization'] as String,
      profileImage: json['profileImage'] as String?,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
      experienceYears: json['experienceYears'] as int,
      bio: json['bio'] as String?,
      education: json['education'] as String?,
      languages: (json['languages'] as List?)?.map((e) => e as String).toList(),
      isAvailable: json['isAvailable'] as bool,
      consultationFee: (json['consultationFee'] as num).toDouble(),
      distance: (json['distance'] as num?)?.toDouble(),
      availableSlots: (json['availableSlots'] as List?)
          ?.map((e) => TimeSlot.fromJson(e))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [id, name, specialization, rating, isAvailable];
}

class TimeSlot extends Equatable {
  final DateTime startTime;
  final DateTime endTime;
  final bool isBooked;

  const TimeSlot({
    required this.startTime,
    required this.endTime,
    required this.isBooked,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      isBooked: json['isBooked'] as bool,
    );
  }

  @override
  List<Object?> get props => [startTime, endTime, isBooked];
}
