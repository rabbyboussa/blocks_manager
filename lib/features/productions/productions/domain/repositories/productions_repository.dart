import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/features/productions/productions/domain/entities/production_entity.dart';

abstract class ProductionsRepository {
  const ProductionsRepository();

  ResultFuture<List<ProductionEntity>> fetchProductions();
}
