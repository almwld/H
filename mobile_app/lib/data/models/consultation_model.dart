import 'package:equatable/equatable.dart';

enum ConsultationStatus {
  pending,
  active,
  completed,
  cancelled,
  expired,
}

enum ConsultationType {
  chat,
  audio,
  video,
}

class ConsultationModel extends Equatable {
  final String id;
  final String patientId;
  final String? patientName;
  final String? doctorId;
  final String? doctorName;
  final String symptoms;
  final String? bodyPart;
  final ConsultationStatus status;
  final ConsultationType type;
  final int priority;
  final DateTime requestedAt;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final int? duration;
  final double? rating;
  final String? review;

  const ConsultationModel({
    required this.id,
    required this.patientId,
    this.patientName,
    this.doctorId,
    this.doctorName,
    required this.symptoms,
    this.bodyPart,
    required this.status,
    required this.type,
    required this.priority,
    required this.requestedAt,
    this.startedAt,
    this.completedAt,
    this.duration,
    this.rating,
    this.review,
  });

  factory ConsultationModel.fromJson(Map<String, dynamic> json) {
    return ConsultationModel(
      id: json['id'] as String,
      patientId: json['patientId'] as String,
      patientName: json['patientName'] as String?,
      doctorId: json['doctorId'] as String?,
      doctorName: json['doctorName'] as String?,
      symptoms: json['symptoms'] as String,
      bodyPart: json['bodyPart'] as String?,
      status: ConsultationStatus.values.firstWhere(
        (e) => e.toString() == json['status'],
      ),
      type: ConsultationType.values.firstWhere(
        (e) => e.toString() == json['type'],
      ),
      priority: json['priority'] as int,
      requestedAt: DateTime.parse(json['requestedAt'] as String),
      startedAt: json['startedAt'] != null
          ? DateTime.parse(json['startedAt'] as String)
          : null,
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
      duration: json['duration'] as int?,
      rating: (json['rating'] as num?)?.toDouble(),
      review: json['review'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'patientName': patientName,
      'doctorId': doctorId,
      'doctorName': doctorName,
      'symptoms': symptoms,
      'bodyPart': bodyPart,
      'status': status.toString(),
      'type': type.toString(),
      'priority': priority,
      'requestedAt': requestedAt.toIso8601String(),
      'startedAt': startedAt?.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'duration': duration,
      'rating': rating,
      'review': review,
    };
  }

  @override
  List<Object?> get props => [id, patientId, status];
}
