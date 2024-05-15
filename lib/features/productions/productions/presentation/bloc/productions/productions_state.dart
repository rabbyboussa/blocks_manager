part of 'productions_bloc.dart';

sealed class ProductionsState extends Equatable {
  const ProductionsState({
    this.productions,
    this.message,
  });

  final List<ProductionEntity>? productions;
  final String? message;

  @override
  List<Object?> get props => [
        productions,
        message,
      ];
}

final class ProductionsInitial extends ProductionsState {}

final class ProductionsFetchingLoadingState extends ProductionsState {}

final class ProductionsFetchingFailedState extends ProductionsState {
  const ProductionsFetchingFailedState({required String message})
      : super(message: message);
}

final class ProductionsFetchingDoneState extends ProductionsState {
  const ProductionsFetchingDoneState(
      {required List<ProductionEntity> productions})
      : super(productions: productions);
}
