import 'package:blocks/core/errors/exception.dart';
import 'package:blocks/core/errors/failure.dart';
import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/features/distributions/distribution_creation/data/models/distribution_line_model.dart';
import 'package:blocks/features/distributions/distribution_details/data/data_sources/distribution_details_data_source.dart';
import 'package:blocks/features/distributions/distribution_details/domain/repository/distribution_details_repository.dart';
import 'package:dartz/dartz.dart';

class DistributionDetailsRepositoryImpl
    implements DistributionDetailsRepository {
  DistributionDetailsRepositoryImpl(
      {required DistributionDetailsDataSource dataSource})
      : _dataSource = dataSource;

  final DistributionDetailsDataSource _dataSource;

  @override
  ResultFuture<List<DistributionLineModel>> getDistributionDetails(
      {required int distributionId}) async {
    try {
      final httpResponse = await _dataSource.getDistributionDetails(
        body: {'distributionId': distributionId},
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
