import 'package:blocks/core/errors/exception.dart';
import 'package:blocks/core/errors/failure.dart';
import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/features/distributions/distributions/data/data_sources/distributions_data_source.dart';
import 'package:blocks/features/distributions/distributions/data/models/distribution_model.dart';
import 'package:blocks/features/distributions/distributions/domain/repositories/distributions_repository.dart';
import 'package:dartz/dartz.dart';

class DistributionsRepositoryImpl implements DistributionsRepository {
  DistributionsRepositoryImpl({required DistributionsDataSource dataSource})
      : _dataSource = dataSource;

  final DistributionsDataSource _dataSource;

  @override
  ResultFuture<List<DistributionModel>> fetchDistributions() async {
    try {
      final httpResponse = await _dataSource.fetchDistributions();

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
