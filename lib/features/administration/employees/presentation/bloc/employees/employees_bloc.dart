import 'package:bloc/bloc.dart';
import 'package:blocks/features/administration/employees/domain/entities/employee_entity.dart';
import 'package:blocks/features/administration/employees/domain/usecases/fetch_employees_usecase.dart';
import 'package:equatable/equatable.dart';

part 'employees_event.dart';
part 'employees_state.dart';

class EmployeesBloc extends Bloc<EmployeesEvent, EmployeesState> {
  EmployeesBloc({required FetchEmployeesUsecase fetchEmployeesUsecase})
      : _fetchEmployeesUsecase = fetchEmployeesUsecase,
        super(EmployeesInitial()) {
    on<FetchEmployeesEvent>(onFetchingEmployees);
    on<EmployeeAddedEvent>(onEmployeeAdded);
    on<EmployeeUpdatedEvent>(onEmployeeUpdated);
  }

  final FetchEmployeesUsecase _fetchEmployeesUsecase;

  Future<void> onEmployeeAdded(
      EmployeeAddedEvent event, Emitter<EmployeesState> emit) async {
    List<EmployeeEntity> employees =
        List<EmployeeEntity>.from(state.employees!);
    EmployeeEntity employee = event.employee.copyWith();
    employees.add(employee);
    emit(EmployeesFetchingDoneState(employees: employees));
  }

  Future<void> onEmployeeUpdated(
      EmployeeUpdatedEvent event, Emitter<EmployeesState> emit) async {
    List<EmployeeEntity> employees =
        List<EmployeeEntity>.from(state.employees!);
    final EmployeeEntity employee = event.employee.copyWith();
    final int index =
        employees.indexWhere((element) => element.id == employee.id);
    employees[index] = employee;
    emit(EmployeesFetchingDoneState(employees: employees));
  }

  Future<void> onFetchingEmployees(
      FetchEmployeesEvent event, Emitter<EmployeesState> emit) async {
    emit(EmployeesFetchingLoadingState());

    final result = await _fetchEmployeesUsecase();

    result.fold(
      (failure) {
        emit(EmployeesFetchingFailedState(message: failure.message));
      },
      (employees) {
        employees.retainWhere((element) => element.siteId == event.siteId);
        emit(
          EmployeesFetchingDoneState(employees: employees),
        );
      },
    );
  }
}
