part of 'employees_bloc.dart';

sealed class EmployeesState extends Equatable {
  const EmployeesState({
    this.employees,
    this.message,
  });

  final List<EmployeeEntity>? employees;
  final String? message;

  @override
  List<Object?> get props => [
        employees,
        message,
      ];
}

final class EmployeesInitial extends EmployeesState {}

final class EmployeesFetchingLoadingState extends EmployeesState {}

final class EmployeesFetchingFailedState extends EmployeesState {
  const EmployeesFetchingFailedState({required String message})
      : super(message: message);
}

final class EmployeesFetchingDoneState extends EmployeesState {
  const EmployeesFetchingDoneState({required List<EmployeeEntity> employees})
      : super(employees: employees);
}
