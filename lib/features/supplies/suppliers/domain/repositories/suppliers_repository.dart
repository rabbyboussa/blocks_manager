import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/features/supplies/suppliers/domain/entities/supplier_entity.dart';

abstract class SuppliersRepository {
  const SuppliersRepository();

  ResultFuture<List<SupplierEntity>> fetchSuppliers();

  ResultFuture<SupplierEntity> addSupplier({required SupplierEntity supplier});
  ResultFutureVoid updateSupplier({required SupplierEntity supplier});
}
