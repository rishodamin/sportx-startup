// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ordered_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderedProduct _$OrderedProductFromJson(Map<String, dynamic> json) =>
    OrderedProduct(
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
      size: json['size'] as String,
    );

Map<String, dynamic> _$OrderedProductToJson(OrderedProduct instance) =>
    <String, dynamic>{
      'product': instance.product,
      'quantity': instance.quantity,
      'size': instance.size,
    };
