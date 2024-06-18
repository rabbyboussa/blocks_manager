// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'] as int,
      siteId: json['siteId'] as int,
      designation: json['designation'] as String,
      description: json['description'] as String?,
      width: json['width'] + 0.0,
      length: json['length'] + 0.0,
      height: json['height'] + 0.0,
      weight: json['weight'] + 0.0,
      unitPrice: json['unitPrice'] + 0.0,
      quantity: json['quantity'] as int,
      imagePath: json['imagePath'] as String?,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'siteId': instance.siteId,
      'designation': instance.designation,
      'description': instance.description,
      'width': instance.width,
      'length': instance.length,
      'height': instance.height,
      'weight': instance.weight,
      'unitPrice': instance.unitPrice,
      'quantity': instance.quantity,
      'imagePath': instance.imagePath,
    };
