// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'production_line_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductionLineModel _$ProductionLineModelFromJson(Map<String, dynamic> json) =>
    ProductionLineModel(
      id: json['id'],
      productionId: json['productionId'],
      product: json['product'],
      quantity: json['quantity'] + 0.0,
    );

Map<String, dynamic> _$ProductionLineModelToJson(
        ProductionLineModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productionId': instance.productionId,
      'product': instance.product,
      'quantity': instance.quantity,
    };
