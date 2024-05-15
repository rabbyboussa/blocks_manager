import 'package:blocks/core/errors/exception.dart';
import 'package:blocks/core/errors/failure.dart';
import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/features/supplies/supply_creation/data/models/supply_line_model.dart';
import 'package:blocks/features/supplies/supply_details/data/data_sources/supply_details_data_source.dart';
import 'package:blocks/features/supplies/supply_details/domain/repository/supply_details_repository.dart';
import 'package:dartz/dartz.dart';

class SupplyDetailsRepositoryImpl implements SupplyDetailsRepository {
  SupplyDetailsRepositoryImpl({required SupplyDetailsDataSource dataSource})
      : _dataSource = dataSource;

  final SupplyDetailsDataSource _dataSource;

  @override
  ResultFuture<List<SupplyLineModel>> getSupplyDetails(
      {required int supplyId}) async {
    try {
      final httpResponse = await _dataSource.getSupplyDetails(
        body: {'supplyId': supplyId},
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
