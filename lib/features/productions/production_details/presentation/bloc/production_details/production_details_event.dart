part of 'production_details_bloc.dart';

sealed class ProductionDetailsEvent extends Equatable {
  const ProductionDetailsEvent();

  @override
  List<Object> get props => [];
}

final class FetchProductionDetailsEvent extends ProductionDetailsEvent {
  const FetchProductionDetailsEvent({required this.productionId});

  final int productionId;

  @override
  List<int> get props => [productionId];
}
