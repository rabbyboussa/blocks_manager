import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/features/productions/products/domain/entities/product_entity.dart';

abstract class ProductsRepository {
  const ProductsRepository();

  ResultFuture<List<ProductEntity>> fetchProducts();

  ResultFuture<ProductEntity> addProduct({required ProductEntity product});

  ResultFutureVoid updateProduct({required ProductEntity product});
}
