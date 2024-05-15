import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/core/usecases/usecase.dart';
import 'package:blocks/features/productions/production_creation/domain/entities/production_line_entity.dart';
import 'package:blocks/features/productions/production_details/domain/repository/production_details_repository.dart';
import 'package:equatable/equatable.dart';

class GetProductionLinesUsecase extends Usecase<
    ResultFuture<List<ProductionLineEntity>>, GetProductionLinesUsecaseParams> {
  const GetProductionLinesUsecase(
      {required ProductionDetailsRepository repository})
      : _repository = repository;

  final ProductionDetailsRepository _repository;

  @override
  ResultFuture<List<ProductionLineEntity>> call(
          GetProductionLinesUsecaseParams params) async =>
      _repository.getProductionLines(
        productionId: params.productionId,
      );
}

class GetProductionLinesUsecaseParams extends Equatable {
  const GetProductionLinesUsecaseParams({required this.productionId});

  final int productionId;

  @override
  List<Object?> get props => [productionId];
}
