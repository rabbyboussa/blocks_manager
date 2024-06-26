part of 'employees_bloc.dart';

sealed class EmployeesEvent extends Equatable {
  const EmployeesEvent();

  @override
  List<Object> get props => [];
}

final class FetchEmployeesEvent extends EmployeesEvent {
  const FetchEmployeesEvent({required this.siteId});

  final int siteId;

  @override
  List<Object> get props => [siteId];
}

final class EmployeeAddedEvent extends EmployeesEvent {
  const EmployeeAddedEvent({required this.employee});

  final EmployeeEntity employee;

  @override
  List<Object> get props => [employee];
}

final class EmployeeUpdatedEvent extends EmployeesEvent {
  const EmployeeUpdatedEvent({required this.employee});

  final EmployeeEntity employee;

  @override
  List<Object> get props => [employee];
}
