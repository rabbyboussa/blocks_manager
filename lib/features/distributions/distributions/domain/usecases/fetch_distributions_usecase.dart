import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/core/usecases/usecase.dart';
import 'package:blocks/features/distributions/distributions/domain/entities/distribution_entity.dart';
import 'package:blocks/features/distributions/distributions/domain/repositories/distributions_repository.dart';

class FetchDistributionsUsecase
    extends UsecaseWithoutParams<ResultFuture<List<DistributionEntity>>> {
  const FetchDistributionsUsecase({required DistributionsRepository repository})
      : _repository = repository;

  final DistributionsRepository _repository;

  @override
  ResultFuture<List<DistributionEntity>> call() async =>
      _repository.fetchDistributions();
}
