import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/features/distributions/distribution_creation/domain/entities/distribution_line_entity.dart';

abstract class DistributionDetailsRepository {
  const DistributionDetailsRepository();

  ResultFuture<List<DistributionLineEntity>> getDistributionDetails(
      {required int distributionId});
}
