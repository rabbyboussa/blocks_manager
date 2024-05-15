import 'package:blocks/core/errors/exception.dart';
import 'package:blocks/core/errors/failure.dart';
import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/features/supplies/materials/domain/entities/material_entity.dart';
import 'package:blocks/features/supplies/supply_creation/data/data_sources/supply_creation_data_source.dart';
import 'package:blocks/features/supplies/supply_creation/domain/entities/supply_line_entity.dart';
import 'package:blocks/features/supplies/supply_creation/domain/repository/supply_creation_repository.dart';
import 'package:dartz/dartz.dart';

class SupplyCreationRepositoryImpl implements SupplyCreationRepository {
  SupplyCreationRepositoryImpl({required SupplyCreationDataSource dataSource})
      : _dataSource = dataSource;

  final SupplyCreationDataSource _dataSource;

  @override
  ResultFutureVoid createSupply({
    required String reference,
    required int supplierId,
    required String creationDate,
    required int accountId,
    required List<MaterialEntity> materials,
    required List<SupplyLineEntity> lines,
  }) async {
    try {
      final httpResponse = await _dataSource.createSupply(
        body: {
          'generalInfo': {
            'reference': reference,
            'supplierId': supplierId,
            'creationDate': creationDate,
            'accountId': accountId,
          },
          'multipleLines': lines.map((e) => {
            'materialId': materials.firstWhere((element) => element.designation == e.material).id,
            'quantity': e.quantity,
          }).toList(),
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
