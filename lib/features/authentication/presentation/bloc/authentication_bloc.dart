import 'package:bloc/bloc.dart';
import 'package:blocks/features/administration/accounts/domain/entities/account_entity.dart';
import 'package:blocks/features/administration/accounts/domain/entities/role_entity.dart';
import 'package:blocks/features/administration/accounts/domain/usecases/fetch_roles_usecase.dart';
import 'package:blocks/features/administration/employees/domain/entities/employee_entity.dart';
import 'package:blocks/features/administration/employees/domain/usecases/fetch_employees_usecase.dart';
import 'package:blocks/features/authentication/domain/usecases/authenticate_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticateUsecase authenticateUsecase,
    required FetchEmployeesUsecase fetchEmployeesUsecase,
    required FetchRolesUsecase fetchRolesUsecase,
  })  : _authenticateUsecase = authenticateUsecase,
        _fetchEmployeesUsecase = fetchEmployeesUsecase,
        _fetchRolesUsecase = fetchRolesUsecase,
        super(AuthenticationInitial()) {
    on<AuthenticateEvent>(onAuthenticate);
    on<FetchDataEvent>(onFetchingData);
  }

  final AuthenticateUsecase _authenticateUsecase;
  final FetchEmployeesUsecase _fetchEmployeesUsecase;
  final FetchRolesUsecase _fetchRolesUsecase;

  Future<void> onFetchingData(
      FetchDataEvent event, Emitter<AuthenticationState> emit) async {
    AccountEntity account = state.account!;
    emit(AuthenticationLoadingState());

    bool hasConnection = await InternetConnectionChecker().hasConnection;

    bool errorOccured = false;
    String errorMessage = '';

    List<RoleEntity> roles = [];
    List<EmployeeEntity> employees = [];

    if (hasConnection) {
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
                },
              ),
            );
          },
        ),
      );
    } else {
      errorOccured = true;
      errorMessage =
          'CONNECTION ERROR: Vérifiez que vous êtes bien connecté à internet et réessayez.';
    }

    if (errorOccured) {
      emit(AuthenticationFailedState(message: errorMessage));
    } else {
      emit(FetchingDataDoneState(
        account: account,
        roles: roles,
        employees: employees,
      ));
    }
  }

  Future<void> onAuthenticate(
      AuthenticateEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoadingState());

    final result = await _authenticateUsecase(
      AuthenticationParams(
        username: event.username,
        password: event.password,
      ),
    );

    result.fold(
      (failure) {
        emit(AuthenticationFailedState(message: failure.message));
      },
      (account) {
        emit(
          AuthenticationDoneState(account: account!),
        );
      },
    );
  }
}
