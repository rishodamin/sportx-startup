// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      name: json['name'] as String,
      description: json['description'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      category: json['category'] as String,
      price: (json['price'] as num).toDouble(),
      finalPrice: (json['finalPrice'] as num).toDouble(),
      id: json['_id'] as String?,
      rating: (json['ratings'] as List<dynamic>?)
          ?.map((e) => Rating.fromJson(e as Map<String, dynamic>))
          .toList(),
      size: json['size'] == null
          ? []
          : (json['size'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'quantity': instance.quantity,
      'images': instance.images,
      'category': instance.category,
      'price': instance.price,
      'finalPrice': instance.finalPrice,
      'id': instance.id,
      'rating': instance.rating,
      'size': instance.size,
    };
