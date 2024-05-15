import 'package:blocks/core/errors/exception.dart';
import 'package:blocks/core/errors/failure.dart';
import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/features/productions/production_creation/data/models/material_used_line_model.dart';
import 'package:blocks/features/productions/production_creation/data/models/production_line_model.dart';
import 'package:blocks/features/productions/production_details/data/data_sources/production_details_data_source.dart';
import 'package:blocks/features/productions/production_details/domain/repository/production_details_repository.dart';
import 'package:dartz/dartz.dart';

class ProductionDetailsRepositoryImpl implements ProductionDetailsRepository {
  ProductionDetailsRepositoryImpl(
      {required ProductionDetailsDataSource dataSource})
      : _dataSource = dataSource;

  final ProductionDetailsDataSource _dataSource;

  @override
  ResultFuture<List<MaterialUsedLineModel>> getProductionMaterialsUsedLines(
      {required int productionId}) async {
    try {
      final httpResponse = await _dataSource.getProductionMaterialsUsedLines(
        body: {'productionId': productionId},
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
  ResultFuture<List<ProductionLineModel>> getProductionLines(
      {required int productionId}) async {
    try {
      final httpResponse = await _dataSource.getProductionLines(
        body: {'productionId': productionId},
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
