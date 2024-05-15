part of 'edit_employee_bloc.dart';

sealed class EditEmployeeEvent extends Equatable {
  const EditEmployeeEvent();

  @override
  List<Object> get props => [];
}

final class EditEvent extends EditEmployeeEvent {
  const EditEvent({
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
