// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material_used_line_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaterialUsedLineModel _$MaterialUsedLineModelFromJson(
        Map<String, dynamic> json) =>
    MaterialUsedLineModel(
      id: json['id'],
      productionId: json['productionId'],
      material: json['material'],
      quantity: json['quantity'] + 0.0,
    );

Map<String, dynamic> _$MaterialUsedLineModelToJson(
        MaterialUsedLineModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productionId': instance.productionId,
      'material': instance.material,
      'quantity': instance.quantity,
    };
