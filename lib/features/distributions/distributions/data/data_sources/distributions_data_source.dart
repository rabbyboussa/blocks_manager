import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/features/distributions/distributions/data/models/distribution_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'distributions_data_source.g.dart';

@RestApi(baseUrl: kAPIBaseUrl)
abstract class DistributionsDataSource {
  factory DistributionsDataSource(Dio dio) = _DistributionsDataSource;

  @GET('distributions/distributions/get_distributions.php')
  Future<HttpResponse<List<DistributionModel>>> fetchDistributions();
}
