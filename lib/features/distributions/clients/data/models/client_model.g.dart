// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientModel _$ClientModelFromJson(Map<String, dynamic> json) => ClientModel(
      id: json['id'],
      denomination: json['denomination'],
      type: json['type'],
      address: json['address'],
      city: json['city'],
      country: json['country'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      fax: json['fax'],
      website: json['website'],
      notes: json['notes'],
    );

Map<String, dynamic> _$ClientModelToJson(ClientModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'denomination': instance.denomination,
      'type': instance.type,
      'address': instance.address,
      'city': instance.city,
      'country': instance.country,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'fax': instance.fax,
      'website': instance.website,
      'notes': instance.notes,
    };
