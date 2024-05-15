import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/features/distributions/distribution_creation/data/models/distribution_line_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'distribution_details_data_source.g.dart';

@RestApi(baseUrl: kAPIBaseUrl)
abstract class DistributionDetailsDataSource {
  factory DistributionDetailsDataSource(Dio dio) =
      _DistributionDetailsDataSource;

  @GET('distributions/distribution_details/get_distribution_details.php')
  Future<HttpResponse<List<DistributionLineModel>>> getDistributionDetails(
      {@Body() required Map<String, dynamic> body});
}
