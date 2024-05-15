part of 'products_bloc.dart';

sealed class ProductsState extends Equatable {
  const ProductsState({
    this.products,
    this.message,
  });

  final List<ProductEntity>? products;
  final String? message;

  @override
  List<Object?> get props => [
        products,
        message,
      ];
}

final class ProductsInitial extends ProductsState {}

final class ProductsFetchingLoadingState extends ProductsState {}

final class ProductsFetchingFailedState extends ProductsState {
  const ProductsFetchingFailedState({required String message})
      : super(message: message);
}

final class ProductsFetchingDoneState extends ProductsState {
  const ProductsFetchingDoneState({required List<ProductEntity> products})
      : super(products: products);
}
