// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supply_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupplyModel _$SupplyModelFromJson(Map<String, dynamic> json) => SupplyModel(
      id: json['id'],
      siteId: json['siteId'],
      reference: json['reference'],
      supplier: json['supplier'],
      creationDate: json['creationDate'],
      operator: json['operator'],
    );

Map<String, dynamic> _$SupplyModelToJson(SupplyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'siteId': instance.siteId,
      'reference': instance.reference,
      'supplier': instance.supplier,
      'creationDate': instance.creationDate,
      'operator': instance.operator,
    };
