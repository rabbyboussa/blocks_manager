import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/features/supplies/supply_creation/domain/entities/supply_line_entity.dart';

abstract class SupplyDetailsRepository {
  const SupplyDetailsRepository();

  ResultFuture<List<SupplyLineEntity>> getSupplyDetails(
      {required int supplyId});
}
