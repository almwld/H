import 'package:equatable/equatable.dart';

enum PlanType {
  basic,
  premium,
  family,
}

enum SubscriptionStatus {
  active,
  expired,
  cancelled,
  pending,
}

class SubscriptionModel extends Equatable {
  final String id;
  final PlanType planType;
  final String planName;
  final double price;
  final int consultationLimit;
  final int familyMembers;
  final bool videoCalls;
  final bool freeDelivery;
  final SubscriptionStatus status;
  final DateTime startDate;
  final DateTime endDate;
  final bool autoRenew;

  const SubscriptionModel({
    required this.id,
    required this.planType,
    required this.planName,
    required this.price,
    required this.consultationLimit,
    required this.familyMembers,
    required this.videoCalls,
    required this.freeDelivery,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.autoRenew,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      id: json['id'] as String,
      planType: PlanType.values.firstWhere(
        (e) => e.toString() == json['planType'],
      ),
      planName: json['planName'] as String,
      price: (json['price'] as num).toDouble(),
      consultationLimit: json['consultationLimit'] as int,
      familyMembers: json['familyMembers'] as int,
      videoCalls: json['videoCalls'] as bool,
      freeDelivery: json['freeDelivery'] as bool,
      status: SubscriptionStatus.values.firstWhere(
        (e) => e.toString() == json['status'],
      ),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      autoRenew: json['autoRenew'] as bool,
    );
  }

  int get remainingConsultations => consultationLimit - usedConsultations;
  int get usedConsultations => 0; // Will be calculated from API
  
  bool get isActive => status == SubscriptionStatus.active && endDate.isAfter(DateTime.now());

  @override
  List<Object?> get props => [id, planType, status];
}
