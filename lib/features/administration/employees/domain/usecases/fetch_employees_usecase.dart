import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/core/usecases/usecase.dart';
import 'package:blocks/features/administration/employees/domain/entities/employee_entity.dart';
import 'package:blocks/features/administration/employees/domain/repositories/employees_repository.dart';

class FetchEmployeesUsecase
    extends UsecaseWithoutParams<ResultFuture<List<EmployeeEntity>>> {
  const FetchEmployeesUsecase({required EmployeesRepository repository})
      : _repository = repository;

  final EmployeesRepository _repository;

  @override
  ResultFuture<List<EmployeeEntity>> call() async =>
      _repository.fetchEmployees();
}
