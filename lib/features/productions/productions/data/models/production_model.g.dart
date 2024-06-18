// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'production_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductionModel _$ProductionModelFromJson(Map<String, dynamic> json) =>
    ProductionModel(
      id: json['id'],
      siteId: json['siteId'],
      reference: json['reference'],
      creationDate: json['creationDate'],
      operator: json['operator'],
    );

Map<String, dynamic> _$ProductionModelToJson(ProductionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'siteId': instance.siteId,
      'reference': instance.reference,
      'creationDate': instance.creationDate,
      'operator': instance.operator,
    };
