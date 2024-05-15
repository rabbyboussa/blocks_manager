import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/core/usecases/usecase.dart';
import 'package:blocks/features/distributions/distribution_creation/domain/entities/distribution_line_entity.dart';
import 'package:blocks/features/distributions/distribution_details/domain/repository/distribution_details_repository.dart';
import 'package:equatable/equatable.dart';

class GetDistributionDetailsUsecase extends Usecase<
    ResultFuture<List<DistributionLineEntity>>,
    GetDistributionDetailsUsecaseParams> {
  const GetDistributionDetailsUsecase(
      {required DistributionDetailsRepository repository})
      : _repository = repository;

  final DistributionDetailsRepository _repository;

  @override
  ResultFuture<List<DistributionLineEntity>> call(
          GetDistributionDetailsUsecaseParams params) async =>
      _repository.getDistributionDetails(
        distributionId: params.distributionId,
      );
}

class GetDistributionDetailsUsecaseParams extends Equatable {
  const GetDistributionDetailsUsecaseParams({required this.distributionId});

  final int distributionId;

  @override
  List<Object?> get props => [distributionId];
}
