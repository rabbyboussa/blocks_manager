import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/core/usecases/usecase.dart';
import 'package:blocks/features/administration/employees/domain/entities/employee_entity.dart';
import 'package:blocks/features/administration/employees/domain/repositories/employees_repository.dart';
import 'package:equatable/equatable.dart';

class UpdateEmployeeUsecase
    extends Usecase<ResultFutureVoid, UpdateEmployeeUsecaseParams> {
  const UpdateEmployeeUsecase({required EmployeesRepository repository})
      : _repository = repository;

  final EmployeesRepository _repository;

  @override
  ResultFutureVoid call(UpdateEmployeeUsecaseParams params) async =>
      _repository.updateEmployee(employee: params.employee);
}

class UpdateEmployeeUsecaseParams extends Equatable {
  const UpdateEmployeeUsecaseParams({required this.employee});

  final EmployeeEntity employee;

  @override
  List<EmployeeEntity> get props => [employee];
}
