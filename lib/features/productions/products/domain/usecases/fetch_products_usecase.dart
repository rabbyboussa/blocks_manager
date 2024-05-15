import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/core/usecases/usecase.dart';
import 'package:blocks/features/productions/products/domain/entities/product_entity.dart';
import 'package:blocks/features/productions/products/domain/repositories/products_repository.dart';

class FetchProductsUsecase
    extends UsecaseWithoutParams<ResultFuture<List<ProductEntity>>> {
  const FetchProductsUsecase({required ProductsRepository repository})
      : _repository = repository;

  final ProductsRepository _repository;

  @override
  ResultFuture<List<ProductEntity>> call() async => _repository.fetchProducts();
}
