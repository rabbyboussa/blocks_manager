part of 'supplies_bloc.dart';

sealed class SuppliesState extends Equatable {
  const SuppliesState({
    this.supplies,
    this.message,
  });

  final List<SupplyEntity>? supplies;
  final String? message;

  @override
  List<Object?> get props => [
        supplies,
        message,
      ];
}

final class ProductsInitial extends SuppliesState {}

final class SuppliesFetchingLoadingState extends SuppliesState {}

final class SuppliesFetchingFailedState extends SuppliesState {
  const SuppliesFetchingFailedState({required String message})
      : super(message: message);
}

final class SuppliesFetchingDoneState extends SuppliesState {
  const SuppliesFetchingDoneState({required List<SupplyEntity> supplies})
      : super(supplies: supplies);
}
