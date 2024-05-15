import 'package:bloc/bloc.dart';
import 'package:blocks/features/productions/production_creation/domain/entities/material_used_line_entity.dart';
import 'package:blocks/features/productions/production_creation/domain/entities/production_line_entity.dart';
import 'package:blocks/features/productions/production_creation/domain/usecases/create_production_usecase.dart';
import 'package:blocks/features/productions/products/domain/entities/product_entity.dart';
import 'package:blocks/features/productions/products/domain/usecases/fetch_products_usecase.dart';
import 'package:blocks/features/supplies/materials/domain/entities/material_entity.dart';
import 'package:blocks/features/supplies/materials/domain/usecases/fetch_materials_usecase.dart';
import 'package:equatable/equatable.dart';

part 'production_creation_event.dart';
part 'production_creation_state.dart';

class ProductionCreationBloc
    extends Bloc<ProductionCreationEvent, ProductionCreationState> {
  ProductionCreationBloc({
    required FetchProductsUsecase fetchProductsUsecase,
    required FetchMaterialsUsecase fetchMaterialsUsecase,
    required CreateProductionUsecase createProductionUsecase,
  })  : _fetchProductsUsecase = fetchProductsUsecase,
        _fetchMaterialsUsecase = fetchMaterialsUsecase,
        _createProductionUsecase = createProductionUsecase,
        super(ProductionCreationInitial()) {
    on<FetchDataEvent>(onDataFetching);
    on<CreateProductionEvent>(onProductionCreation);
  }

  final FetchProductsUsecase _fetchProductsUsecase;
  final FetchMaterialsUsecase _fetchMaterialsUsecase;

  final CreateProductionUsecase _createProductionUsecase;

  Future<void> onProductionCreation(CreateProductionEvent event,
      Emitter<ProductionCreationState> emit) async {
    emit(const ProductionCreationLoadingState());

    final result = await _createProductionUsecase(CreateProductionUsecaseParams(
      reference: event.reference,
      creationDate: event.creationDate,
      accountId: event.accountId,
      products: event.products,
      materials: event.materials,
      productionlines: event.productionLines,
      materialsUsedLines: event.materialsUsedLines,
    ));

    result.fold(
        (failure) =>
            emit(ProductionCreationFailedState(message: failure.message)),
        (_) => emit(const ProductionCreationDoneState()));
  }

  Future<void> onDataFetching(
      FetchDataEvent event, Emitter<ProductionCreationState> emit) async {
    emit(DataFetchingLoadingState());

    bool errorOccured = false;
    String errorMessage = '';

    List<ProductEntity> products = [];
    List<MaterialEntity> materials = [];

    await _fetchProductsUsecase().then(
      (productsResult) => productsResult.fold(
        (failure) {
          errorOccured = true;
          errorMessage = failure.message;
        },
        (productsFetched) async {
          products = productsFetched;
          await _fetchMaterialsUsecase().then(
            (materialsResult) => materialsResult.fold(
              (failure) {
                errorOccured = true;
                errorMessage = failure.message;
              },
              (materialsFetched) async {
                materials = materialsFetched;
              },
            ),
          );
        },
      ),
    );

    if (errorOccured) {
      emit(DataFetchingFailedState(message: errorMessage));
    } else {
      emit(DataFetchingDoneState(
        products: products,
        materials: materials,
      ));
    }
  }
}
