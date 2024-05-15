import 'package:blocks/core/errors/exception.dart';
import 'package:blocks/core/errors/failure.dart';
import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/features/supplies/suppliers/data/data_sources/suppliers_data_source.dart';
import 'package:blocks/features/supplies/suppliers/data/models/supplier_model.dart';
import 'package:blocks/features/supplies/suppliers/domain/entities/supplier_entity.dart';
import 'package:blocks/features/supplies/suppliers/domain/repositories/suppliers_repository.dart';
import 'package:dartz/dartz.dart';

class SuppliersRepositoryImpl implements SuppliersRepository {
  SuppliersRepositoryImpl({required SuppliersDataSource dataSource})
      : _dataSource = dataSource;

  final SuppliersDataSource _dataSource;

  @override
  ResultFuture<List<SupplierModel>> fetchSuppliers() async {
    try {
      final httpResponse = await _dataSource.fetchSuppliers();

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
  ResultFuture<SupplierModel> addSupplier(
      {required SupplierEntity supplier}) async {
    try {
      final httpResponse = await _dataSource.addSupplier(
        body: {
          'denomination': supplier.denomination,
          'type': supplier.type,
          'address': supplier.address,
          'city': supplier.city,
          'country': supplier.country,
          'phoneNumber': supplier.phoneNumber,
          'email': supplier.email,
          'fax': supplier.fax,
          'website': supplier.website,
          'notes': supplier.notes,
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
  ResultFutureVoid updateSupplier({required SupplierEntity supplier}) async {
    try {
      final httpResponse = await _dataSource.updateSupplier(
        body: {
          'idToUpdate': supplier.id,
          'newDenomination': supplier.denomination,
          'newType': supplier.type,
          'newAddress': supplier.address,
          'newCity': supplier.city,
          'newCountry': supplier.country,
          'newPhoneNumber': supplier.phoneNumber,
          'newEmail': supplier.email,
          'newFax': supplier.fax,
          'newWebsite': supplier.website,
          'newNotes': supplier.notes,
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
