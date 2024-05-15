import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/features/supplies/supplies/data/models/supply_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'supplies_data_source.g.dart';

@RestApi(baseUrl: kAPIBaseUrl)
abstract class SuppliesDataSource {
  factory SuppliesDataSource(Dio dio) = _SuppliesDataSource;

  @GET('supplies/supplies/get_supplies.php')
  Future<HttpResponse<List<SupplyModel>>> fetchSupplies();
}
