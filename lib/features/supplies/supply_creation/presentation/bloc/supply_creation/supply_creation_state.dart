part of 'supply_creation_bloc.dart';

sealed class SupplyCreationState extends Equatable {
  const SupplyCreationState();

  @override
  List<Object> get props => [];
}

final class SupplyCreationInitial extends SupplyCreationState {}

final class DataFetchingLoadingState extends SupplyCreationState {}

final class DataFetchingFailedState extends SupplyCreationState {
  const DataFetchingFailedState({required this.message});

  final String message;

  @override
  List<String> get props => [message];
}

final class DataFetchingDoneState extends SupplyCreationState {
  const DataFetchingDoneState(
      {required this.materials, required this.suppliers});

  final List<MaterialEntity> materials;
  final List<SupplierEntity> suppliers;

  @override
  List<Object> get props => [
        materials,
        suppliers,
      ];
}

final class SupplyCreationLoadingState extends SupplyCreationState {
  const SupplyCreationLoadingState();
}

final class SupplyCreationFailedState extends SupplyCreationState {
  const SupplyCreationFailedState({required this.message});

  final String message;

  @override
  List<String> get props => [message];
}

final class SupplyCreationDoneState extends SupplyCreationState {
  const SupplyCreationDoneState();
}
