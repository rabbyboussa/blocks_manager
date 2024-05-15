import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/core/usecases/usecase.dart';
import 'package:blocks/features/supplies/suppliers/domain/entities/supplier_entity.dart';
import 'package:blocks/features/supplies/suppliers/domain/repositories/suppliers_repository.dart';
import 'package:equatable/equatable.dart';

class UpdateSupplierUsecase
    extends Usecase<ResultFutureVoid, UpdateSupplierUsecaseParams> {
  const UpdateSupplierUsecase({required SuppliersRepository repository})
      : _repository = repository;

  final SuppliersRepository _repository;

  @override
  ResultFutureVoid call(UpdateSupplierUsecaseParams params) async =>
      _repository.updateSupplier(supplier: params.supplier);
}

class UpdateSupplierUsecaseParams extends Equatable {
  const UpdateSupplierUsecaseParams({required this.supplier});

  final SupplierEntity supplier;

  @override
  List<Object> get props => [supplier];
}
