import 'package:blocks/core/errors/exception.dart';
import 'package:blocks/core/errors/failure.dart';
import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/features/administration/accounts/data/data_sources/accounts_data_source.dart';
import 'package:blocks/features/administration/accounts/data/models/account_model.dart';
import 'package:blocks/features/administration/accounts/data/models/role_model.dart';
import 'package:blocks/features/administration/accounts/domain/entities/account_entity.dart';
import 'package:blocks/features/administration/accounts/domain/repositories/accounts_repository.dart';
import 'package:dartz/dartz.dart';

class AccountsRepositoryImpl implements AccountsRepository {
  AccountsRepositoryImpl({required AccountsDataSource dataSource})
      : _dataSource = dataSource;

  final AccountsDataSource _dataSource;

  @override
  ResultFuture<List<AccountModel>> fetchAccounts() async {
    try {
      final httpResponse = await _dataSource.fetchAccounts();

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
  ResultFuture<List<RoleModel>> fetchRoles() async {
    try {
      final httpResponse = await _dataSource.fetchRoles();

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
  ResultFuture<AccountModel> addAccount(
      {required AccountEntity account}) async {
    try {
      final httpResponse = await _dataSource.addAccount(
        body: {
          'siteId': account.siteId,
          'type': account.type,
          'employeeId': account.employeeId,
          'clientId': account.clientId,
          'username': account.username,
          'password': account.password,
          'roleId': account.roleId,
          'status': account.status,
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
  ResultFutureVoid updateAccount({required AccountEntity account}) async {
    try {
      final httpResponse = await _dataSource.updateAccount(
        body: {
          'idToUpdate': account.id,
          'newEmployeeId': account.employeeId,
          'newUsername': account.username,
          'newPassword': account.password,
          'newRoleId': account.roleId,
          'newStatus': account.status,
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
