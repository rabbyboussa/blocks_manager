import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/features/administration/employees/data/models/employee_model.dart';
import 'package:blocks/features/supplies/materials/data/models/material_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'employees_data_source.g.dart';

@RestApi(baseUrl: kAPIBaseUrl)
abstract class EmployeesDataSource {
  factory EmployeesDataSource(Dio dio) = _EmployeesDataSource;

  @GET('administration/employees/get_employees.php')
  Future<HttpResponse<List<EmployeeModel>>> fetchEmployees();

  @POST('administration/employees/add_employee.php')
  Future<HttpResponse<EmployeeModel>> addEmployee(
      {@Body() required Map<String, dynamic> body});

  @PUT('administration/employees/update_employee.php')
  Future<HttpResponse<void>> updateEmployee(
      {@Body() required Map<String, dynamic> body});
}
