import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/core/usecases/usecase.dart';
import 'package:blocks/features/supplies/supply_creation/domain/entities/supply_line_entity.dart';
import 'package:blocks/features/supplies/supply_details/domain/repository/supply_details_repository.dart';
import 'package:equatable/equatable.dart';

class GetSupplyDetailsUsecase extends Usecase<
    ResultFuture<List<SupplyLineEntity>>, GetSupplyDetailsUsecaseParams> {
  const GetSupplyDetailsUsecase({required SupplyDetailsRepository repository})
      : _repository = repository;

  final SupplyDetailsRepository _repository;

  @override
  ResultFuture<List<SupplyLineEntity>> call(
          GetSupplyDetailsUsecaseParams params) async =>
      _repository.getSupplyDetails(
        supplyId: params.supplyId,
      );
}

class GetSupplyDetailsUsecaseParams extends Equatable {
  const GetSupplyDetailsUsecaseParams({required this.supplyId});

  final int supplyId;

  @override
  List<Object?> get props => [supplyId];
}
