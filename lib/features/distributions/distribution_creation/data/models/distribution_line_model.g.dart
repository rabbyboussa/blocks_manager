// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'distribution_line_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DistributionLineModel _$DistributionLineModelFromJson(
        Map<String, dynamic> json) =>
    DistributionLineModel(
      id: json['id'],
      distributionId: json['distributionId'],
      product: json['product'],
      quantity: json['quantity'] + 0.0,
    );

Map<String, dynamic> _$DistributionLineModelToJson(
        DistributionLineModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'distributionId': instance.distributionId,
      'product': instance.product,
      'quantity': instance.quantity,
    };
