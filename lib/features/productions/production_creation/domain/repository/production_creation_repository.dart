import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/features/productions/production_creation/domain/entities/material_used_line_entity.dart';
import 'package:blocks/features/productions/production_creation/domain/entities/production_line_entity.dart';
import 'package:blocks/features/productions/products/domain/entities/product_entity.dart';
import 'package:blocks/features/supplies/materials/domain/entities/material_entity.dart';

abstract class ProductionCreationRepository {
  const ProductionCreationRepository();

  ResultFuture<void> createProduction({
    required String reference,
    required String creationDate,
    required int accountId,
    required int siteId,
    required List<ProductEntity> products,
    required List<MaterialEntity> materials,
    required List<ProductionLineEntity> productionlines,
    required List<MaterialUsedLineEntity> materialsUsedLines,
  });
}
