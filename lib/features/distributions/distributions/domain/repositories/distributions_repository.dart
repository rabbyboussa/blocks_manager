import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/features/distributions/distributions/domain/entities/distribution_entity.dart';

abstract class DistributionsRepository {
  const DistributionsRepository();

  ResultFuture<List<DistributionEntity>> fetchDistributions();
}
