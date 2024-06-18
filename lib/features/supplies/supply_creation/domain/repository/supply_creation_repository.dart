import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/features/supplies/materials/domain/entities/material_entity.dart';
import 'package:blocks/features/supplies/supply_creation/domain/entities/supply_line_entity.dart';

abstract class SupplyCreationRepository {
  const SupplyCreationRepository();

  ResultFuture<void> createSupply({
    required int siteId,
    required String reference,
    required int supplierId,
    required String creationDate,
    required int accountId,
    required List<MaterialEntity> materials,
    required List<SupplyLineEntity> lines,
  });
}
