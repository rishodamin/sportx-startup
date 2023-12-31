import 'package:json_annotation/json_annotation.dart';
import 'package:sportx/models/user_models/rating.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final String name;
  final String description;
  final double quantity;
  final List<String> images;
  final String category;
  final double price;
  final double finalPrice;
  final String? id;
  final List<Rating>? rating;
  final List<String> size;

  Product({
    required this.name,
    required this.description,
    required this.quantity,
    required this.images,
    required this.category,
    required this.price,
    required this.finalPrice,
    required this.size,
    this.id,
    this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
