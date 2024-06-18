// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'distribution_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DistributionModel _$DistributionModelFromJson(Map<String, dynamic> json) =>
    DistributionModel(
      id: json['id'],
      siteId: json['siteId'],
      reference: json['reference'],
      client: json['client'],
      creationDate: json['creationDate'],
      operator: json['operator'],
    );

Map<String, dynamic> _$DistributionModelToJson(DistributionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'siteId': instance.siteId,
      'reference': instance.reference,
      'client': instance.client,
      'creationDate': instance.creationDate,
      'operator': instance.operator,
    };
