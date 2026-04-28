import 'package:equatable/equatable.dart';

class PrescriptionModel extends Equatable {
  final String id;
  final String consultationId;
  final String doctorId;
  final String doctorName;
  final String patientId;
  final String patientName;
  final String diagnosis;
  final List<MedicineModel> medicines;
  final String? instructions;
  final DateTime issuedAt;
  final DateTime? validUntil;
  final String? digitalSignature;

  const PrescriptionModel({
    required this.id,
    required this.consultationId,
    required this.doctorId,
    required this.doctorName,
    required this.patientId,
    required this.patientName,
    required this.diagnosis,
    required this.medicines,
    this.instructions,
    required this.issuedAt,
    this.validUntil,
    this.digitalSignature,
  });

  factory PrescriptionModel.fromJson(Map<String, dynamic> json) {
    return PrescriptionModel(
      id: json['id'] as String,
      consultationId: json['consultationId'] as String,
      doctorId: json['doctorId'] as String,
      doctorName: json['doctorName'] as String,
      patientId: json['patientId'] as String,
      patientName: json['patientName'] as String,
      diagnosis: json['diagnosis'] as String,
      medicines: (json['medicines'] as List)
          .map((e) => MedicineModel.fromJson(e))
          .toList(),
      instructions: json['instructions'] as String?,
      issuedAt: DateTime.parse(json['issuedAt'] as String),
      validUntil: json['validUntil'] != null
          ? DateTime.parse(json['validUntil'] as String)
          : null,
      digitalSignature: json['digitalSignature'] as String?,
    );
  }

  @override
  List<Object?> get props => [id, consultationId];
}

class MedicineModel extends Equatable {
  final String id;
  final String name;
  final String dosage;
  final String frequency;
  final String duration;
  final String? notes;

  const MedicineModel({
    required this.id,
    required this.name,
    required this.dosage,
    required this.frequency,
    required this.duration,
    this.notes,
  });

  factory MedicineModel.fromJson(Map<String, dynamic> json) {
    return MedicineModel(
      id: json['id'] as String,
      name: json['name'] as String,
      dosage: json['dosage'] as String,
      frequency: json['frequency'] as String,
      duration: json['duration'] as String,
      notes: json['notes'] as String?,
    );
  }

  @override
  List<Object?> get props => [id, name, dosage];
}
