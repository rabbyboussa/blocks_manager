import 'package:blocks/core/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'distribution_creation_data_source.g.dart';

@RestApi(baseUrl: kAPIBaseUrl)
abstract class DistributionCreationDataSource {
  factory DistributionCreationDataSource(Dio dio) =
      _DistributionCreationDataSource;

  @POST('distributions/distribution_creation/create_distribution.php')
  Future<HttpResponse<void>> createDistribution(
      {@Body() required Map<String, dynamic> body});
}
