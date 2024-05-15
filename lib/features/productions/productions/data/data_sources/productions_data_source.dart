import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/features/productions/productions/data/models/production_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'productions_data_source.g.dart';

@RestApi(baseUrl: kAPIBaseUrl)
abstract class ProductionsDataSource {
  factory ProductionsDataSource(Dio dio) = _ProductionsDataSource;

  @GET('productions/productions/get_productions.php')
  Future<HttpResponse<List<ProductionModel>>> fetchProductions();
}
