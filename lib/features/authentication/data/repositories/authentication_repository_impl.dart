import 'dart:convert';

import 'package:blocks/core/errors/exception.dart';
import 'package:blocks/core/errors/failure.dart';
import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/features/administration/accounts/data/models/account_model.dart';
import 'package:blocks/features/authentication/data/data_sources/authentication_data_source.dart';
import 'package:blocks/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl({required AuthenticationDataSource dataSource})
      : _authenticationDataSource = dataSource;

  final AuthenticationDataSource _authenticationDataSource;

  @override
  ResultFuture<AccountModel?> authenticate(
      {required String username, required String password}) async {
    try {
      final httpResponse = await _authenticationDataSource.authenticate(body: {
        'username': username,
        'password': password,
      });

      Map<String, dynamic> decodedResponse =
          jsonDecode(httpResponse.response.toString());

      if (decodedResponse['statusCode'] == 200) {
        return Right(httpResponse.data);
      }
      if (decodedResponse['statusCode'] == 401) {
        throw const ApiException(
          statusCode: 401,
          message: 'Les identifiants que vous avez saisis sont incorrectes.',
        );
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
