import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../data/models/consultation_model.dart';
import '../../core/utils/helpers.dart';

class ConsultationCard extends StatelessWidget {
  final ConsultationModel consultation;
  final VoidCallback onTap;

  const ConsultationCard({
    super.key,
    required this.consultation,
    required this.onTap,
  });

  Color _getStatusColor(ConsultationStatus status) {
    switch (status) {
      case ConsultationStatus.completed:
        return Colors.green;
      case ConsultationStatus.active:
        return Colors.blue;
      case ConsultationStatus.pending:
        return Colors.orange;
      case ConsultationStatus.cancelled:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(ConsultationStatus status) {
    switch (status) {
      case ConsultationStatus.completed:
        return 'مكتملة';
      case ConsultationStatus.active:
        return 'نشطة';
      case ConsultationStatus.pending:
        return 'قيد الانتظار';
      case ConsultationStatus.cancelled:
        return 'ملغية';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: AppColors.primary.withOpacity(0.1),
          child: const Icon(Icons.medical_services, color: AppColors.primary),
        ),
        title: Text(consultation.doctorName ?? 'طبيب'),
        subtitle: Text(Helpers.formatDate(consultation.requestedAt)),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: _getStatusColor(consultation.status).withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            _getStatusText(consultation.status),
            style: TextStyle(
              color: _getStatusColor(consultation.status),
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
