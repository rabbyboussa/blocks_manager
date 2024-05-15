import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/core/usecases/usecase.dart';
import 'package:blocks/features/administration/employees/domain/entities/employee_entity.dart';
import 'package:blocks/features/administration/employees/domain/repositories/employees_repository.dart';
import 'package:equatable/equatable.dart';

class AddEmployeeUsecase
    extends Usecase<ResultFuture<EmployeeEntity>, AddEmployeeUsecaseParams> {
  const AddEmployeeUsecase({required EmployeesRepository repository})
      : _repository = repository;

  final EmployeesRepository _repository;

  @override
  ResultFuture<EmployeeEntity> call(AddEmployeeUsecaseParams params) async =>
      _repository.addEmployee(employee: params.employee);
}

class AddEmployeeUsecaseParams extends Equatable {
  const AddEmployeeUsecaseParams({required this.employee});

  final EmployeeEntity employee;

  @override
  List<EmployeeEntity> get props => [employee];
}
