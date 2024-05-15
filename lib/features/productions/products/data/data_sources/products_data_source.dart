import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/features/productions/products/data/models/product_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'products_data_source.g.dart';

@RestApi(baseUrl: kAPIBaseUrl)
abstract class ProductsDataSource {
  factory ProductsDataSource(Dio dio) = _ProductsDataSource;

  @GET('productions/products/get_products.php')
  Future<HttpResponse<List<ProductModel>>> fetchProducts();

  @POST('productions/products/add_product.php')
  Future<HttpResponse<ProductModel>> addProduct(
      {@Body() required Map<String, dynamic> body});

  @PUT('productions/products/update_product.php')
  Future<HttpResponse<void>> updateProduct(
      {@Body() required Map<String, dynamic> body});
}
