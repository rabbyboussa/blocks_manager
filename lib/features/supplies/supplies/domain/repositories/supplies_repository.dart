import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/features/supplies/supplies/domain/entities/supply_entity.dart';

abstract class SuppliesRepository {
  const SuppliesRepository();

  ResultFuture<List<SupplyEntity>> fetchSupplies();
}
