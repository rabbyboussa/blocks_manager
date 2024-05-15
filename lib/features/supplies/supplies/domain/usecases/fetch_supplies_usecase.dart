import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/core/usecases/usecase.dart';
import 'package:blocks/features/supplies/supplies/domain/entities/supply_entity.dart';
import 'package:blocks/features/supplies/supplies/domain/repositories/supplies_repository.dart';

class FetchSuppliesUsecase
    extends UsecaseWithoutParams<ResultFuture<List<SupplyEntity>>> {
  const FetchSuppliesUsecase({required SuppliesRepository repository})
      : _repository = repository;

  final SuppliesRepository _repository;

  @override
  ResultFuture<List<SupplyEntity>> call() async => _repository.fetchSupplies();
}
