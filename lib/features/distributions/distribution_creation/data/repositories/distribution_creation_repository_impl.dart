import 'package:blocks/core/errors/exception.dart';
import 'package:blocks/core/errors/failure.dart';
import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/features/distributions/distribution_creation/data/data_sources/distribution_creation_data_source.dart';
import 'package:blocks/features/distributions/distribution_creation/domain/entities/distribution_line_entity.dart';
import 'package:blocks/features/distributions/distribution_creation/domain/repository/distribution_creation_repository.dart';
import 'package:blocks/features/productions/products/domain/entities/product_entity.dart';
import 'package:dartz/dartz.dart';

class DistributionCreationRepositoryImpl
    implements DistributionCreationRepository {
  DistributionCreationRepositoryImpl(
      {required DistributionCreationDataSource dataSource})
      : _dataSource = dataSource;

  final DistributionCreationDataSource _dataSource;

  @override
  ResultFutureVoid createDistribution({
    required String reference,
    required int clientId,
    required String creationDate,
    required int accountId,
    required List<ProductEntity> products,
    required List<DistributionLineEntity> lines,
  }) async {
    try {
      final httpResponse = await _dataSource.createDistribution(
        body: {
          'generalInfo': {
            'reference': reference,
            'clientId': clientId,
            'creationDate': creationDate,
            'accountId': accountId,
          },
          'multipleLines': lines
              .map((e) => {
                    'productId': products
                        .firstWhere(
                            (element) => element.designation == e.product)
                        .id,
                    'quantity': e.quantity,
                  })
              .toList(),
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
