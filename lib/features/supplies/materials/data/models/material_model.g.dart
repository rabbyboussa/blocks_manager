// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaterialModel _$MaterialModelFromJson(Map<String, dynamic> json) =>
    MaterialModel(
      id: json['id'],
      siteId: json['siteId'],
      designation: json['designation'],
      description: json['description'],
      measurementUnit: json['measurementUnit'],
      quantity: json['quantity'],
      imagePath: json['imagePath'],
    );

Map<String, dynamic> _$MaterialModelToJson(MaterialModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'siteId': instance.siteId,
      'designation': instance.designation,
      'description': instance.description,
      'measurementUnit': instance.measurementUnit,
      'quantity': instance.quantity,
      'imagePath': instance.imagePath,
    };
