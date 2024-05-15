import 'package:bloc/bloc.dart';
import 'package:blocks/features/productions/production_creation/domain/entities/material_used_line_entity.dart';
import 'package:blocks/features/productions/production_creation/domain/entities/production_line_entity.dart';
import 'package:blocks/features/productions/production_details/domain/usecases/get_production_lines_usecase%20copy.dart';
import 'package:blocks/features/productions/production_details/domain/usecases/get_production_materials_used_lines_usecase.dart';
import 'package:equatable/equatable.dart';

part 'production_details_event.dart';
part 'production_details_state.dart';

class ProductionDetailsBloc
    extends Bloc<ProductionDetailsEvent, ProductionDetailsState> {
  ProductionDetailsBloc({
    required GetProductionMaterialsUsedLinesUsecase
        getProductionMaterialsUsedLinesUsecase,
    required GetProductionLinesUsecase getProductionLinesUsecase,
  })  : _getProductionMaterialsUsedLinesUsecase =
            getProductionMaterialsUsedLinesUsecase,
        _getProductionLinesUsecase = getProductionLinesUsecase,
        super(ProductionDetailsInitial()) {
    on<FetchProductionDetailsEvent>(onFetching);
  }

  final GetProductionMaterialsUsedLinesUsecase
      _getProductionMaterialsUsedLinesUsecase;
  final GetProductionLinesUsecase _getProductionLinesUsecase;

  Future<void> onFetching(FetchProductionDetailsEvent event,
      Emitter<ProductionDetailsState> emit) async {
    emit(ProductionDetailsFetchingLoadingState());

    bool errorOccured = false;
    String errorMessage = '';

    List<MaterialUsedLineEntity> materialsUsedLines = [];
    List<ProductionLineEntity> productionLines = [];

    await _getProductionMaterialsUsedLinesUsecase(
            GetProductionMaterialsUsedLinesUsecaseParams(
                productionId: event.productionId))
        .then(
      (materialsUsedLinesResult) => materialsUsedLinesResult.fold(
        (failure) {
          errorOccured = true;
          errorMessage = failure.message;
        },
        (materialsUsedLinesFetched) async {
          materialsUsedLines = materialsUsedLinesFetched;
          await _getProductionLinesUsecase(GetProductionLinesUsecaseParams(
                  productionId: event.productionId))
              .then(
            (productionLinesResult) => productionLinesResult.fold(
              (failure) {
                errorOccured = true;
                errorMessage = failure.message;
              },
              (productionLinesResultFetched) async {
                productionLines = productionLinesResultFetched;
              },
            ),
          );
        },
      ),
    );

    if (errorOccured) {
      emit(ProductionDetailsFetchingFailedState(message: errorMessage));
    } else {
      emit(ProductionDetailsFetchingDoneState(
        materialsUsedLines: materialsUsedLines,
        productionLines: productionLines,
      ));
    }
  }
}
