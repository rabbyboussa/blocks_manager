import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/core/usecases/usecase.dart';
import 'package:blocks/features/productions/products/domain/entities/product_entity.dart';
import 'package:blocks/features/productions/products/domain/repositories/products_repository.dart';
import 'package:equatable/equatable.dart';

class AddProductUsecase
    extends Usecase<ResultFuture<ProductEntity>, AddProductUsecaseParams> {
  const AddProductUsecase({required ProductsRepository repository})
      : _repository = repository;

  final ProductsRepository _repository;

  @override
  ResultFuture<ProductEntity> call(AddProductUsecaseParams params) async =>
      _repository.addProduct(
        product: params.product,
        siteId: params.siteId,
      );
}

class AddProductUsecaseParams extends Equatable {
  const AddProductUsecaseParams({
    required this.product,
    required this.siteId,
  });

  final ProductEntity product;
  final int siteId;

  @override
  List<Object?> get props => [
        product,
        siteId,
      ];
}
