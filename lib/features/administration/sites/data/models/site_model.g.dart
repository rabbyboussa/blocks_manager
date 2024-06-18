// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'site_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SiteModel _$SiteModelFromJson(Map<String, dynamic> json) => SiteModel(
      id: json['id'],
      name: json['name'],
      active: json['active'],
      address: json['address'],
      city: json['city'],
      countryId: json['countryId'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      fax: json['fax'],
      website: json['website'],
      notes: json['notes'],
    );

Map<String, dynamic> _$SiteModelToJson(SiteModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'active': instance.active,
      'address': instance.address,
      'city': instance.city,
      'countryId': instance.countryId,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'fax': instance.fax,
      'website': instance.website,
      'notes': instance.notes,
    };
