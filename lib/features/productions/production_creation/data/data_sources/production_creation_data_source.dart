import 'package:blocks/core/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'production_creation_data_source.g.dart';

@RestApi(baseUrl: kAPIBaseUrl)
abstract class ProductionCreationDataSource {
  factory ProductionCreationDataSource(Dio dio) = _ProductionCreationDataSource;

  @POST('productions/production_creation/create_production.php')
  Future<HttpResponse<void>> createProduction(
      {@Body() required Map<String, dynamic> body});
}
