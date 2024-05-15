import 'package:blocks/core/errors/exception.dart';
import 'package:blocks/core/errors/failure.dart';
import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/features/distributions/clients/data/data_sources/clients_data_source.dart';
import 'package:blocks/features/distributions/clients/data/models/client_model.dart';
import 'package:blocks/features/distributions/clients/domain/entities/client_entity.dart';
import 'package:blocks/features/distributions/clients/domain/repositories/clients_repository.dart';
import 'package:dartz/dartz.dart';

class ClientsRepositoryImpl implements ClientsRepository {
  ClientsRepositoryImpl({required ClientsDataSource dataSource})
      : _dataSource = dataSource;

  final ClientsDataSource _dataSource;

  @override
  ResultFuture<List<ClientModel>> fetchClients() async {
    try {
      final httpResponse = await _dataSource.fetchClients();

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
  ResultFuture<ClientModel> addClient({required ClientEntity client}) async {
    try {
      final httpResponse = await _dataSource.addClient(
        body: {
          'denomination': client.denomination,
          'type': client.type,
          'address': client.address,
          'city': client.city,
          'country': client.country,
          'phoneNumber': client.phoneNumber,
          'email': client.email,
          'fax': client.fax,
          'website': client.website,
          'notes': client.notes,
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
  ResultFutureVoid updateClient({required ClientEntity client}) async {
    try {
      final httpResponse = await _dataSource.updateClient(
        body: {
          'idToUpdate': client.id,
          'newDenomination': client.denomination,
          'newType': client.type,
          'newAddress': client.address,
          'newCity': client.city,
          'newCountry': client.country,
          'newPhoneNumber': client.phoneNumber,
          'newEmail': client.email,
          'newFax': client.fax,
          'newWebsite': client.website,
          'newNotes': client.notes,
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
