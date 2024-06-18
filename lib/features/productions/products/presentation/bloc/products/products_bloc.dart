import 'package:bloc/bloc.dart';
import 'package:blocks/features/productions/products/domain/entities/product_entity.dart';
import 'package:blocks/features/productions/products/domain/usecases/fetch_products_usecase.dart';
import 'package:equatable/equatable.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc({required FetchProductsUsecase fetchProductsUsecase})
      : _fetchProductsUsecase = fetchProductsUsecase,
        super(ProductsInitial()) {
    on<FetchProductsEvent>(onFetching);
    on<ProductAddedEvent>(onProductAdded);
    on<ProductUpdatedEvent>(onProductUpdated);
  }

  final FetchProductsUsecase _fetchProductsUsecase;

  Future<void> onProductAdded(
      ProductAddedEvent event, Emitter<ProductsState> emit) async {
    List<ProductEntity> products = List<ProductEntity>.from(state.products!);
    ProductEntity product = event.product.copyWith();
    products.add(product);
    emit(ProductsFetchingDoneState(products: products));
  }

  Future<void> onProductUpdated(
      ProductUpdatedEvent event, Emitter<ProductsState> emit) async {
    List<ProductEntity> products = List<ProductEntity>.from(state.products!);
    final ProductEntity product = event.product.copyWith();
    final int index =
        products.indexWhere((element) => element.id == product.id);
    products[index] = product;
    emit(ProductsFetchingDoneState(products: products));
  }

  Future<void> onFetching(
      FetchProductsEvent event, Emitter<ProductsState> emit) async {
    emit(ProductsFetchingLoadingState());

    final result = await _fetchProductsUsecase();

    result.fold(
      (failure) {
        emit(ProductsFetchingFailedState(message: failure.message));
      },
      (products) {
        products.retainWhere((element) => element.siteId == event.siteId);

        emit(
          ProductsFetchingDoneState(products: products),
        );
      },
    );
  }
}
