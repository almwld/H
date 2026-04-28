import 'package:equatable/equatable.dart';

class PharmacyModel extends Equatable {
  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final double rating;
  final int reviewCount;
  final String? phone;
  final bool isOpen;
  final int deliveryTime;
  final double deliveryFee;
  final double? distance;

  const PharmacyModel({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.rating,
    required this.reviewCount,
    this.phone,
    required this.isOpen,
    required this.deliveryTime,
    required this.deliveryFee,
    this.distance,
  });

  factory PharmacyModel.fromJson(Map<String, dynamic> json) {
    return PharmacyModel(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
      phone: json['phone'] as String?,
      isOpen: json['isOpen'] as bool,
      deliveryTime: json['deliveryTime'] as int,
      deliveryFee: (json['deliveryFee'] as num).toDouble(),
      distance: (json['distance'] as num?)?.toDouble(),
    );
  }

  @override
  List<Object?> get props => [id, name, rating, isOpen];
}

class ProductModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final String? imageUrl;
  final bool requiresPrescription;
  final int stock;

  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.imageUrl,
    required this.requiresPrescription,
    required this.stock,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String?,
      requiresPrescription: json['requiresPrescription'] as bool,
      stock: json['stock'] as int,
    );
  }

  @override
  List<Object?> get props => [id, name, price];
}
