import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/core/usecases/usecase.dart';
import 'package:blocks/features/supplies/suppliers/domain/entities/supplier_entity.dart';
import 'package:blocks/features/supplies/suppliers/domain/repositories/suppliers_repository.dart';

class FetchSuppliersUsecase
    extends UsecaseWithoutParams<ResultFuture<List<SupplierEntity>>> {
  const FetchSuppliersUsecase({required SuppliersRepository repository})
      : _repository = repository;

  final SuppliersRepository _repository;

  @override
  ResultFuture<List<SupplierEntity>> call() async =>
      _repository.fetchSuppliers();
}
