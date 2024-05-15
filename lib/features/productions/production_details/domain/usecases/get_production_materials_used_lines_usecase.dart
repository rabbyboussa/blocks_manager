import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/core/usecases/usecase.dart';
import 'package:blocks/features/productions/production_creation/domain/entities/material_used_line_entity.dart';
import 'package:blocks/features/productions/production_details/domain/repository/production_details_repository.dart';
import 'package:equatable/equatable.dart';

class GetProductionMaterialsUsedLinesUsecase extends Usecase<
    ResultFuture<List<MaterialUsedLineEntity>>,
    GetProductionMaterialsUsedLinesUsecaseParams> {
  const GetProductionMaterialsUsedLinesUsecase(
      {required ProductionDetailsRepository repository})
      : _repository = repository;

  final ProductionDetailsRepository _repository;

  @override
  ResultFuture<List<MaterialUsedLineEntity>> call(
          GetProductionMaterialsUsedLinesUsecaseParams params) async =>
      _repository.getProductionMaterialsUsedLines(
        productionId: params.productionId,
      );
}

class GetProductionMaterialsUsedLinesUsecaseParams extends Equatable {
  const GetProductionMaterialsUsedLinesUsecaseParams(
      {required this.productionId});

  final int productionId;

  @override
  List<Object?> get props => [productionId];
}
