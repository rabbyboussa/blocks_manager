import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/features/supplies/materials/data/models/material_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'materials_data_source.g.dart';

@RestApi(baseUrl: kAPIBaseUrl)
abstract class MaterialsDataSource {
  factory MaterialsDataSource(Dio dio) = _MaterialsDataSource;

  @GET('supplies/materials/get_materials.php')
  Future<HttpResponse<List<MaterialModel>>> fetchMaterials();

  @POST('supplies/materials/add_material.php')
  Future<HttpResponse<MaterialModel>> addMaterial(
      {@Body() required Map<String, dynamic> body});

  @PUT('supplies/materials/update_material.php')
  Future<HttpResponse<void>> updateMaterial(
      {@Body() required Map<String, dynamic> body});
}
