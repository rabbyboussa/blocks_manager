import 'package:blocks/core/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'supply_creation_data_source.g.dart';

@RestApi(baseUrl: kAPIBaseUrl)
abstract class SupplyCreationDataSource {
  factory SupplyCreationDataSource(Dio dio) = _SupplyCreationDataSource;

  @POST('supplies/supply_creation/create_supply.php')
  Future<HttpResponse<void>> createSupply(
      {@Body() required Map<String, dynamic> body});
}
