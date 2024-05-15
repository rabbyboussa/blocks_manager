import 'package:blocks/core/errors/exception.dart';
import 'package:blocks/core/errors/failure.dart';
import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/features/supplies/supplies/data/data_sources/supplies_data_source.dart';
import 'package:blocks/features/supplies/supplies/data/models/supply_model.dart';
import 'package:blocks/features/supplies/supplies/domain/repositories/supplies_repository.dart';
import 'package:dartz/dartz.dart';

class SuppliesRepositoryImpl implements SuppliesRepository {
  SuppliesRepositoryImpl({required SuppliesDataSource dataSource})
      : _dataSource = dataSource;

  final SuppliesDataSource _dataSource;

  @override
  ResultFuture<List<SupplyModel>> fetchSupplies() async {
    try {
      final httpResponse = await _dataSource.fetchSupplies();

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
