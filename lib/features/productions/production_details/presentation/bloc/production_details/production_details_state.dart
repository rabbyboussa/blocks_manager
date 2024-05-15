part of 'production_details_bloc.dart';

sealed class ProductionDetailsState extends Equatable {
  const ProductionDetailsState({
    this.materialsUsedLines,
    this.productionLines,
    this.message,
  });

  final List<MaterialUsedLineEntity>? materialsUsedLines;
  final List<ProductionLineEntity>? productionLines;
  final String? message;

  @override
  List<Object?> get props => [
        materialsUsedLines,
        productionLines,
        message,
      ];
}

final class ProductionDetailsInitial extends ProductionDetailsState {}

final class ProductionDetailsFetchingLoadingState
    extends ProductionDetailsState {}

final class ProductionDetailsFetchingFailedState
    extends ProductionDetailsState {
  const ProductionDetailsFetchingFailedState({required String message})
      : super(message: message);
}

final class ProductionDetailsFetchingDoneState extends ProductionDetailsState {
  const ProductionDetailsFetchingDoneState({
    required List<MaterialUsedLineEntity> materialsUsedLines,
    required List<ProductionLineEntity> productionLines,
  }) : super(
          materialsUsedLines: materialsUsedLines,
          productionLines: productionLines,
        );
}
