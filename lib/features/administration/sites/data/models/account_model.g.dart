// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountModel _$AccountModelFromJson(Map<String, dynamic> json) => AccountModel(
      id: json['id'],
      type: json['type'],
      employeeId: json['employeeId'],
      clientId: json['clientId'],
      username: json['username'],
      password: json['password'],
      roleId: json['roleId'],
      status: json['status'],
    );

Map<String, dynamic> _$AccountModelToJson(AccountModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'employeeId': instance.employeeId,
      'clientId': instance.clientId,
      'username': instance.username,
      'password': instance.password,
      'roleId': instance.roleId,
      'status': instance.status,
    };
