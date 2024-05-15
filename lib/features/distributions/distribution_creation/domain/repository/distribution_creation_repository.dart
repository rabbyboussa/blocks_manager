import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/features/distributions/distribution_creation/domain/entities/distribution_line_entity.dart';
import 'package:blocks/features/productions/products/domain/entities/product_entity.dart';

abstract class DistributionCreationRepository {
  const DistributionCreationRepository();

  ResultFuture<void> createDistribution({
    required String reference,
    required int clientId,
    required String creationDate,
    required int accountId,
    required List<ProductEntity> products,
    required List<DistributionLineEntity> lines,
  });
}
