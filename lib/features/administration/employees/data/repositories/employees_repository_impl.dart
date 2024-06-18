import 'package:blocks/core/errors/exception.dart';
import 'package:blocks/core/errors/failure.dart';
import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/features/administration/employees/data/data_sources/employees_data_source.dart';
import 'package:blocks/features/administration/employees/data/models/employee_model.dart';
import 'package:blocks/features/administration/employees/domain/entities/employee_entity.dart';
import 'package:blocks/features/administration/employees/domain/repositories/employees_repository.dart';
import 'package:dartz/dartz.dart';

class EmployeesRepositoryImpl implements EmployeesRepository {
  EmployeesRepositoryImpl({required EmployeesDataSource dataSource})
      : _dataSource = dataSource;

  final EmployeesDataSource _dataSource;

  @override
  ResultFuture<List<EmployeeModel>> fetchEmployees() async {
    try {
      final httpResponse = await _dataSource.fetchEmployees();

      if (httpResponse.response.statusCode == 200) {
        return Right(httpResponse.data);
      } else {
        throw ApiException(
          statusCode: httpResponse.response.statusCode!,
          message: httpResponse.response.statusMessage!,
        );
      }
    } on ApiException catch (e) {
      return Left(ApiFailure(statusCode: e.statusCode, message: e.message));
    } catch (e) {
      return Left(ApiFailure(statusCode: 505, message: e.toString()));
    }
  }

  @override
  ResultFuture<EmployeeModel> addEmployee(
      {required EmployeeEntity employee}) async {
    try {
      print(employee.siteId);

      final httpResponse = await _dataSource.addEmployee(
        body: {
          'siteId': employee.siteId,
          'firstname': employee.firstname,
          'lastname': employee.lastname,
          'genre': employee.genre,
          'birthdate': employee.birthdate,
          'birthplace': employee.birthplace,
          'nationality': employee.nationality,
          'function': employee.function,
          'address': employee.address,
          'city': employee.city,
          'country': employee.country,
          'phoneNumber': employee.phoneNumber,
          'email': employee.email,
          'fax': employee.fax,
          'imagePath': employee.imagePath,
        },
      );

      if (httpResponse.response.statusCode == 200) {
        return Right(httpResponse.data);
      } else {
        throw ApiException(
          statusCode: httpResponse.response.statusCode!,
          message: httpResponse.response.statusMessage!,
        );
      }
    } on ApiException catch (e) {
      return Left(ApiFailure(statusCode: e.statusCode, message: e.message));
    } catch (e) {
      return Left(ApiFailure(statusCode: 505, message: e.toString()));
    }
  }

  @override
  ResultFutureVoid updateEmployee({required EmployeeEntity employee}) async {
    try {
      final httpResponse = await _dataSource.updateEmployee(
        body: {
          'idToUpdate': employee.id,
          'newFirstname': employee.firstname,
          'newLastname': employee.lastname,
          'newGenre': employee.genre,
          'newBirthdate': employee.birthdate,
          'newBirthplace': employee.birthplace,
          'newNationality': employee.nationality,
          'newFunction': employee.function,
          'newAddress': employee.address,
          'newCity': employee.city,
          'newCountry': employee.country,
          'newPhoneNumber': employee.phoneNumber,
          'newEmail': employee.email,
          'newFax': employee.fax,
          'newImagePath': employee.imagePath,
        },
      );

      if (httpResponse.response.statusCode == 200) {
        return Right(httpResponse.data);
      } else {
        throw ApiException(
          statusCode: httpResponse.response.statusCode!,
          message: httpResponse.response.statusMessage!,
        );
      }
    } on ApiException catch (e) {
      return Left(ApiFailure(statusCode: e.statusCode, message: e.message));
    } catch (e) {
      return Left(ApiFailure(statusCode: 505, message: e.toString()));
    }
  }
}
