import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/features/productions/production_creation/data/models/material_used_line_model.dart';
import 'package:blocks/features/productions/production_creation/data/models/production_line_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'production_details_data_source.g.dart';

@RestApi(baseUrl: kAPIBaseUrl)
abstract class ProductionDetailsDataSource {
  factory ProductionDetailsDataSource(Dio dio) = _ProductionDetailsDataSource;

  @GET('productions/production_details/get_production_materials_used_lines.php')
  Future<HttpResponse<List<MaterialUsedLineModel>>>
      getProductionMaterialsUsedLines(
          {@Body() required Map<String, dynamic> body});

  @GET('productions/production_details/get_production_lines.php')
  Future<HttpResponse<List<ProductionLineModel>>> getProductionLines(
      {@Body() required Map<String, dynamic> body});
}
