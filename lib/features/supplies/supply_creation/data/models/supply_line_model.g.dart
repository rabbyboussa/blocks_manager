// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supply_line_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupplyLineModel _$SupplyLineModelFromJson(Map<String, dynamic> json) =>
    SupplyLineModel(
      id: json['id'],
      supplyId: json['supplyId'],
      material: json['material'],
      quantity: json['quantity'] + 0.0,
    );

Map<String, dynamic> _$SupplyLineModelToJson(SupplyLineModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'supplyId': instance.supplyId,
      'material': instance.material,
      'quantity': instance.quantity,
    };
