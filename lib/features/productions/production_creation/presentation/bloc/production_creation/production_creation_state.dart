part of 'production_creation_bloc.dart';

sealed class ProductionCreationState extends Equatable {
  const ProductionCreationState();

  @override
  List<Object> get props => [];
}

final class ProductionCreationInitial extends ProductionCreationState {}

final class DataFetchingLoadingState extends ProductionCreationState {}

final class DataFetchingFailedState extends ProductionCreationState {
  const DataFetchingFailedState({required this.message});

  final String message;

  @override
  List<String> get props => [message];
}

final class DataFetchingDoneState extends ProductionCreationState {
  const DataFetchingDoneState({
    required this.products,
    required this.materials,
  });

  final List<ProductEntity> products;
  final List<MaterialEntity> materials;

  @override
  List<Object> get props => [
        products,
        materials,
      ];
}

final class ProductionCreationLoadingState extends ProductionCreationState {
  const ProductionCreationLoadingState();
}

final class ProductionCreationFailedState extends ProductionCreationState {
  const ProductionCreationFailedState({required this.message});

  final String message;

  @override
  List<String> get props => [message];
}

final class ProductionCreationDoneState extends ProductionCreationState {
  const ProductionCreationDoneState();
}
