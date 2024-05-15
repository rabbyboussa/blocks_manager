part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState({
    this.account,
    this.employees,
    this.roles,
    this.message,
  });

  final AccountEntity? account;
  final List<EmployeeEntity>? employees;
  final List<RoleEntity>? roles;
  final String? message;

  @override
  List<Object?> get props => [
        account,
        employees,
        roles,
        message,
      ];
}

final class AuthenticationInitial extends AuthenticationState {}

final class AuthenticationLoadingState extends AuthenticationState {}

final class AuthenticationDoneState extends AuthenticationState {
  const AuthenticationDoneState({required AccountEntity account})
      : super(account: account);
}

final class AuthenticationFailedState extends AuthenticationState {
  const AuthenticationFailedState({
    required String message,
  }) : super(message: message);
}

final class FetchingDataDoneState extends AuthenticationState {
  const FetchingDataDoneState({
    required AccountEntity account,
    required List<EmployeeEntity> employees,
    required List<RoleEntity> roles,
  }) : super(
          account: account,
          employees: employees,
          roles: roles,
        );
}
