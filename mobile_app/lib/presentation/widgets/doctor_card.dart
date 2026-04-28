import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../data/models/doctor_model.dart';

class DoctorCard extends StatelessWidget {
  final DoctorModel doctor;
  final VoidCallback onTap;

  const DoctorCard({
    super.key,
    required this.doctor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(right: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: 180,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: const Icon(Icons.person, size: 40, color: AppColors.primary),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  doctor.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  doctor.specialization,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(doctor.rating.toString()),
                    const SizedBox(width: 8),
                    Text(
                      '(${doctor.reviewCount})',
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: doctor.isAvailable ? Colors.green.shade100 : Colors.red.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    doctor.isAvailable ? 'متاح الآن' : 'غير متاح',
                    style: TextStyle(
                      fontSize: 10,
                      color: doctor.isAvailable ? Colors.green : Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
