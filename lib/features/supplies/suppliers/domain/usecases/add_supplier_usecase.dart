import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/core/usecases/usecase.dart';
import 'package:blocks/features/supplies/suppliers/domain/entities/supplier_entity.dart';
import 'package:blocks/features/supplies/suppliers/domain/repositories/suppliers_repository.dart';
import 'package:equatable/equatable.dart';

class AddSupplierUsecase
    extends Usecase<ResultFuture<SupplierEntity>, AddSupplierUsecaseParams> {
  const AddSupplierUsecase({required SuppliersRepository repository})
      : _repository = repository;

  final SuppliersRepository _repository;

  @override
  ResultFuture<SupplierEntity> call(AddSupplierUsecaseParams params) async =>
      _repository.addSupplier(
        supplier: params.supplier,
        siteId: params.siteId,
      );
}

class AddSupplierUsecaseParams extends Equatable {
  const AddSupplierUsecaseParams({
    required this.supplier,
    required this.siteId,
  });

  final SupplierEntity supplier;
  final int siteId;

  @override
  List<Object?> get props => [
        supplier,
        siteId,
      ];
}
