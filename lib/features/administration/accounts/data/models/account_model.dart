import 'package:blocks/features/administration/accounts/domain/entities/account_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account_model.g.dart';

@JsonSerializable()
class AccountModel extends AccountEntity {
  const AccountModel({
    required int id,
    required int siteId,
    required String type,
    int? employeeId,
    int? clientId,
    required String username,
    required String password,
    int? roleId,
    required int status,
  }) : super(
          id: id,
          siteId: siteId,
          type: type,
          employeeId: employeeId,
          clientId: clientId,
          username: username,
          password: password,
          roleId: roleId,
          status: status,
        );

  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);

  Map<String, dynamic> toJson() => _$AccountModelToJson(this);
}
