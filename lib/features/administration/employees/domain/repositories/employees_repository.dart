import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/features/administration/employees/domain/entities/employee_entity.dart';

abstract class EmployeesRepository {
  const EmployeesRepository();

  ResultFuture<List<EmployeeEntity>> fetchEmployees();

  ResultFuture<EmployeeEntity> addEmployee({required EmployeeEntity employee});

  ResultFutureVoid updateEmployee({required EmployeeEntity employee});
}
