import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/features/supplies/supply_creation/data/models/supply_line_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'supply_details_data_source.g.dart';

@RestApi(baseUrl: kAPIBaseUrl)
abstract class SupplyDetailsDataSource {
  factory SupplyDetailsDataSource(Dio dio) = _SupplyDetailsDataSource;

  @GET('supplies/supply_details/get_supply_details.php')
  Future<HttpResponse<List<SupplyLineModel>>> getSupplyDetails(
      {@Body() required Map<String, dynamic> body});
}
