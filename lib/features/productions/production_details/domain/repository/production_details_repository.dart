import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/features/productions/production_creation/domain/entities/material_used_line_entity.dart';
import 'package:blocks/features/productions/production_creation/domain/entities/production_line_entity.dart';

abstract class ProductionDetailsRepository {
  const ProductionDetailsRepository();

  ResultFuture<List<MaterialUsedLineEntity>> getProductionMaterialsUsedLines(
      {required int productionId});

  ResultFuture<List<ProductionLineEntity>> getProductionLines(
      {required int productionId});
}
