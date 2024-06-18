import 'package:blocks/core/errors/exception.dart';
import 'package:blocks/core/errors/failure.dart';
import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/features/productions/production_creation/data/data_sources/production_creation_data_source.dart';
import 'package:blocks/features/productions/production_creation/domain/entities/material_used_line_entity.dart';
import 'package:blocks/features/productions/production_creation/domain/entities/production_line_entity.dart';
import 'package:blocks/features/productions/production_creation/domain/repository/production_creation_repository.dart';
import 'package:blocks/features/productions/products/domain/entities/product_entity.dart';
import 'package:blocks/features/supplies/materials/domain/entities/material_entity.dart';
import 'package:dartz/dartz.dart';

class ProductionCreationRepositoryImpl implements ProductionCreationRepository {
  ProductionCreationRepositoryImpl(
      {required ProductionCreationDataSource dataSource})
      : _dataSource = dataSource;

  final ProductionCreationDataSource _dataSource;

  @override
  ResultFutureVoid createProduction({
    required String reference,
    required String creationDate,
    required int accountId,
    required int siteId,
    required List<ProductEntity> products,
    required List<MaterialEntity> materials,
    required List<ProductionLineEntity> productionlines,
    required List<MaterialUsedLineEntity> materialsUsedLines,
  }) async {
    try {
      final httpResponse = await _dataSource.createProduction(
        body: {
          'generalInfo': {
            'reference': reference,
            'creationDate': creationDate,
            'accountId': accountId,
            'siteId': siteId,
          },
          'materialsUsedLines': materialsUsedLines
              .map((e) => {
                    'materialId': materials
                        .firstWhere(
                            (element) => element.designation == e.material)
                        .id,
                    'quantity': e.quantity,
                  })
              .toList(),
          'productionLines': productionlines
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
