part of 'edit_employee_bloc.dart';

sealed class EditEmployeeState extends Equatable {
  const EditEmployeeState();

  @override
  List<Object> get props => [];
}

final class EditEmployeeInitial extends EditEmployeeState {}

final class EditEmployeeLoadingState extends EditEmployeeState {}

final class EditEmployeeFailedState extends EditEmployeeState {
  const EditEmployeeFailedState({required this.message});

  final String message;

  @override
  List<String> get props => [message];
}

final class EditEmployeeDoneState extends EditEmployeeState {
  const EditEmployeeDoneState({
    required this.employee,
    this.modification = false,
  });

  final EmployeeEntity employee;
  final bool modification;

  @override
  List<Object> get props => [
        employee,
        modification,
      ];
}
