part of 'supplies_bloc.dart';

sealed class SuppliesEvent extends Equatable {
  const SuppliesEvent();

  @override
  List<Object> get props => [];
}

final class FetchSuppliesEvent extends SuppliesEvent {}

final class SupplyAddedEvent extends SuppliesEvent {
  const SupplyAddedEvent({required this.supply});

  final SupplyEntity supply;

  @override
  List<SupplyEntity> get props => [supply];
}

final class SupplyUpdatedEvent extends SuppliesEvent {
  const SupplyUpdatedEvent({required this.supply});

  final SupplyEntity supply;

  @override
  List<Object> get props => [supply];
}
