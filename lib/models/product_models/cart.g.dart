// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
      size: json['size'] as String,
    );

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'product': instance.product,
      'quantity': instance.quantity,
      'size': instance.size,
    };
