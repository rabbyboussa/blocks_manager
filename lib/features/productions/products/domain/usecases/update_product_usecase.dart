import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/core/usecases/usecase.dart';
import 'package:blocks/features/productions/products/domain/entities/product_entity.dart';
import 'package:blocks/features/productions/products/domain/repositories/products_repository.dart';
import 'package:equatable/equatable.dart';

class UpdateProductUsecase
    extends Usecase<ResultFutureVoid, UpdateProductUsecaseParams> {
  const UpdateProductUsecase({required ProductsRepository repository})
      : _repository = repository;

  final ProductsRepository _repository;

  @override
  ResultFutureVoid call(UpdateProductUsecaseParams params) async =>
      _repository.updateProduct(product: params.product);
}

class UpdateProductUsecaseParams extends Equatable {
  const UpdateProductUsecaseParams({required this.product});

  final ProductEntity product;

  @override
  List<Object?> get props => [product];
}
