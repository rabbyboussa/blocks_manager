part of 'accounts_bloc.dart';

sealed class AccountsState extends Equatable {
  const AccountsState({
    this.accounts,
    this.roles,
    this.employees,
    this.clients,
    this.message,
  });

  final List<AccountEntity>? accounts;
  final List<RoleEntity>? roles;
  final List<EmployeeEntity>? employees;
  final List<ClientEntity>? clients;
  final String? message;

  @override
  List<Object?> get props => [
        accounts,
        roles,
        employees,
        clients,
        message,
      ];
}

final class AccountsInitial extends AccountsState {}

final class AccountsFetchingLoadingState extends AccountsState {}

final class AccountsFetchingFailedState extends AccountsState {
  const AccountsFetchingFailedState({required String message})
      : super(message: message);
}

final class AccountsFetchingDoneState extends AccountsState {
  const AccountsFetchingDoneState({
    required List<AccountEntity> accounts,
    required List<RoleEntity> roles,
    required List<EmployeeEntity> employees,
    required List<ClientEntity> clients,
  }) : super(
          accounts: accounts,
          roles: roles,
          employees: employees,
          clients: clients,
        );
}
