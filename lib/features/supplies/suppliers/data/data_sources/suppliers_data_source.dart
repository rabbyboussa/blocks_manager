import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/features/supplies/suppliers/data/models/supplier_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'suppliers_data_source.g.dart';

@RestApi(baseUrl: kAPIBaseUrl)
abstract class SuppliersDataSource {
  factory SuppliersDataSource(Dio dio) = _SuppliersDataSource;

  @GET('supplies/suppliers/get_suppliers.php')
  Future<HttpResponse<List<SupplierModel>>> fetchSuppliers();

  @POST('supplies/suppliers/add_supplier.php')
  Future<HttpResponse<SupplierModel>> addSupplier(
      {@Body() required Map<String, dynamic> body});

  @PUT('supplies/suppliers/update_supplier.php')
  Future<HttpResponse<void>> updateSupplier(
      {@Body() required Map<String, dynamic> body});
}
