import 'package:equatable/equatable.dart';

enum OrderStatus {
  pending,
  confirmed,
  preparing,
  ready,
  onDelivery,
  delivered,
  cancelled,
}

class OrderModel extends Equatable {
  final String id;
  final String pharmacyId;
  final String pharmacyName;
  final List<OrderItem> items;
  final double subtotal;
  final double deliveryFee;
  final double total;
  final OrderStatus status;
  final DateTime createdAt;
  final DateTime? estimatedDelivery;
  final DateTime? deliveredAt;
  final String deliveryAddress;
  final String? trackingNumber;

  const OrderModel({
    required this.id,
    required this.pharmacyId,
    required this.pharmacyName,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.status,
    required this.createdAt,
    this.estimatedDelivery,
    this.deliveredAt,
    required this.deliveryAddress,
    this.trackingNumber,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String,
      pharmacyId: json['pharmacyId'] as String,
      pharmacyName: json['pharmacyName'] as String,
      items: (json['items'] as List)
          .map((e) => OrderItem.fromJson(e))
          .toList(),
      subtotal: (json['subtotal'] as num).toDouble(),
      deliveryFee: (json['deliveryFee'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      status: OrderStatus.values.firstWhere(
        (e) => e.toString() == json['status'],
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      estimatedDelivery: json['estimatedDelivery'] != null
          ? DateTime.parse(json['estimatedDelivery'] as String)
          : null,
      deliveredAt: json['deliveredAt'] != null
          ? DateTime.parse(json['deliveredAt'] as String)
          : null,
      deliveryAddress: json['deliveryAddress'] as String,
      trackingNumber: json['trackingNumber'] as String?,
    );
  }

  @override
  List<Object?> get props => [id, status, total];
}

class OrderItem extends Equatable {
  final String productId;
  final String productName;
  final int quantity;
  final double price;

  const OrderItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      quantity: json['quantity'] as int,
      price: (json['price'] as num).toDouble(),
    );
  }

  double get total => price * quantity;

  @override
  List<Object?> get props => [productId, quantity, price];
}
