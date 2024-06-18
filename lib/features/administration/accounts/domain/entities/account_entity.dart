import 'package:equatable/equatable.dart';

class AccountEntity extends Equatable {
  const AccountEntity({
    this.id,
    required this.siteId,
    required this.type,
    this.employeeId,
    this.clientId,
    required this.username,
    required this.password,
    this.roleId,
    this.status = 1,
  });

  final int? id;
  final int siteId;
  final String type;
  final int? employeeId;
  final int? clientId;
  final String username;
  final String password;
  final int? roleId;
  final int status;

  AccountEntity copyWith({
    int? id,
    int? siteId,
    String? type,
    int? employeeId,
    int? clientId,
    String? username,
    String? password,
    int? roleId,
    int? status,
  }) {
    return AccountEntity(
      id: id ?? this.id,
      siteId: siteId ?? this.siteId,
      type: type ?? this.type,
      employeeId: employeeId ?? this.employeeId,
      clientId: clientId ?? this.clientId,
      username: username ?? this.username,
      password: password ?? this.password,
      roleId: roleId ?? this.roleId,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        id,
        siteId,
        employeeId,
        username,
        password,
        roleId,
        status,
      ];
}
