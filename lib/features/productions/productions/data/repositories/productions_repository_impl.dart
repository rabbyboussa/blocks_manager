import 'package:blocks/core/errors/exception.dart';
import 'package:blocks/core/errors/failure.dart';
import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/features/productions/productions/data/data_sources/productions_data_source.dart';
import 'package:blocks/features/productions/productions/data/models/production_model.dart';
import 'package:blocks/features/productions/productions/domain/repositories/productions_repository.dart';
import 'package:dartz/dartz.dart';

class ProductionsRepositoryImpl implements ProductionsRepository {
  ProductionsRepositoryImpl({required ProductionsDataSource dataSource})
      : _dataSource = dataSource;

  final ProductionsDataSource _dataSource;

  @override
  ResultFuture<List<ProductionModel>> fetchProductions() async {
    try {
      final httpResponse = await _dataSource.fetchProductions();

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
