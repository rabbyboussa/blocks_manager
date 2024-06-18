part of 'products_bloc.dart';

sealed class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

final class FetchProductsEvent extends ProductsEvent {
  const FetchProductsEvent({required this.siteId});

  final int siteId;

  @override
  List<int> get props => [siteId];
}

final class ProductAddedEvent extends ProductsEvent {
  const ProductAddedEvent({required this.product});

  final ProductEntity product;

  @override
  List<ProductEntity> get props => [product];
}

final class ProductUpdatedEvent extends ProductsEvent {
  const ProductUpdatedEvent({required this.product});

  final ProductEntity product;

  @override
  List<Object> get props => [product];
}
