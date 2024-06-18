// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeModel _$EmployeeModelFromJson(Map<String, dynamic> json) =>
    EmployeeModel(
      id: json['id'],
      siteId: json['siteId'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      genre: json['genre'],
      birthdate: json['birthdate'],
      birthplace: json['birthplace'],
      nationality: json['nationality'],
      function: json['function'],
      address: json['address'],
      city: json['city'],
      country: json['country'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      fax: json['fax'],
      imagePath: json['imagePath'],
    );

Map<String, dynamic> _$EmployeeModelToJson(EmployeeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'siteId': instance.siteId,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'genre': instance.genre,
      'birthdate': instance.birthdate,
      'birthplace': instance.birthplace,
      'nationality': instance.nationality,
      'function': instance.function,
      'address': instance.address,
      'city': instance.city,
      'country': instance.country,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'fax': instance.fax,
      'imagePath': instance.imagePath,
    };
