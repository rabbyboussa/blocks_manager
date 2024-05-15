import 'package:bloc/bloc.dart';
import 'package:blocks/features/administration/accounts/domain/entities/account_entity.dart';
import 'package:blocks/features/administration/accounts/domain/entities/role_entity.dart';
import 'package:blocks/features/administration/accounts/domain/usecases/fetch_accounts_usecase.dart';
import 'package:blocks/features/administration/accounts/domain/usecases/fetch_roles_usecase.dart';
import 'package:blocks/features/administration/employees/domain/entities/employee_entity.dart';
import 'package:blocks/features/administration/employees/domain/usecases/fetch_employees_usecase.dart';
import 'package:blocks/features/distributions/clients/domain/entities/client_entity.dart';
import 'package:blocks/features/distributions/clients/domain/usecases/fetch_clients_usecase.dart';
import 'package:equatable/equatable.dart';

part 'accounts_event.dart';
part 'accounts_state.dart';

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  AccountsBloc({
    required FetchEmployeesUsecase fetchEmployeesUsecase,
    required FetchClientsUsecase fetchClientsUsecase,
    required FetchRolesUsecase fetchRolesUsecase,
    required FetchAccountsUsecase fetchAccountsUsecase,
  })  : _fetchEmployeesUsecase = fetchEmployeesUsecase,
        _fetchClientsUsecase = fetchClientsUsecase,
        _fetchRolesUsecase = fetchRolesUsecase,
        _fetchAccountsUsecase = fetchAccountsUsecase,
        super(AccountsInitial()) {
    on<FetchAccountsEvent>(onFetching);
    on<AccountAddedEvent>(onAccountAdded);
    on<AccountUpdatedEvent>(onAccountUpdated);
  }

  final FetchEmployeesUsecase _fetchEmployeesUsecase;
  final FetchClientsUsecase _fetchClientsUsecase;
  final FetchRolesUsecase _fetchRolesUsecase;
  final FetchAccountsUsecase _fetchAccountsUsecase;

  Future<void> onAccountAdded(
      AccountAddedEvent event, Emitter<AccountsState> emit) async {
    List<AccountEntity> accounts = List<AccountEntity>.from(state.accounts!);
    AccountEntity account = event.account.copyWith();
    accounts.add(account);
    emit(AccountsFetchingDoneState(
      accounts: accounts,
      roles: state.roles!,
      employees: state.employees!,
      clients: state.clients!,
    ));
  }

  Future<void> onAccountUpdated(
      AccountUpdatedEvent event, Emitter<AccountsState> emit) async {
    List<AccountEntity> accounts = List<AccountEntity>.from(state.accounts!);
    final AccountEntity account = event.account.copyWith();
    final int index =
        accounts.indexWhere((element) => element.id == account.id);
    accounts[index] = account;
    emit(AccountsFetchingDoneState(
      accounts: accounts,
      roles: state.roles!,
      employees: state.employees!,
      clients: state.clients!,
    ));
  }

  Future<void> onFetching(
      FetchAccountsEvent event, Emitter<AccountsState> emit) async {
    emit(AccountsFetchingLoadingState());

    bool errorOccured = false;
    String errorMessage = '';

    List<AccountEntity> accounts = [];
    List<RoleEntity> roles = [];
    List<EmployeeEntity> employees = [];
    List<ClientEntity> clients = [];

    await _fetchEmployeesUsecase().then(
      (employeesResult) => employeesResult.fold(
        (failure) {
          errorOccured = true;
          errorMessage = failure.message;
        },
        (employeesFetched) async {
          employees = employeesFetched;
          await _fetchRolesUsecase().then(
            (rolesResult) => rolesResult.fold(
              (failure) {
                errorOccured = true;
                errorMessage = failure.message;
              },
              (rolesFetched) async {
                roles = rolesFetched;
                await _fetchAccountsUsecase().then(
                  (accountResult) => accountResult.fold(
                    (failure) {
                      errorOccured = true;
                      errorMessage = failure.message;
                    },
                    (accountsFetched) async {
                      accounts = accountsFetched;
                      await _fetchClientsUsecase().then(
                        (clientsResult) => clientsResult.fold((failure) {
                          errorOccured = true;
                          errorMessage = failure.message;
                        }, (clientsFetched) => clients = clientsFetched),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );

    if (errorOccured) {
      emit(AccountsFetchingFailedState(message: errorMessage));
    } else {
      emit(AccountsFetchingDoneState(
        accounts: accounts,
        roles: roles,
        employees: employees,
        clients: clients,
      ));
    }
  }
}
