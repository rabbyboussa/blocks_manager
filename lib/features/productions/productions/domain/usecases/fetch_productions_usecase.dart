import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/core/usecases/usecase.dart';
import 'package:blocks/features/productions/productions/domain/entities/production_entity.dart';
import 'package:blocks/features/productions/productions/domain/repositories/productions_repository.dart';

class FetchProductionsUsecase
    extends UsecaseWithoutParams<ResultFuture<List<ProductionEntity>>> {
  const FetchProductionsUsecase({required ProductionsRepository repository})
      : _repository = repository;

  final ProductionsRepository _repository;

  @override
  ResultFuture<List<ProductionEntity>> call() async =>
      _repository.fetchProductions();
}
