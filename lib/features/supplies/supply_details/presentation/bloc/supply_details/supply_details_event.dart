part of 'supply_details_bloc.dart';

sealed class SupplyDetailsEvent extends Equatable {
  const SupplyDetailsEvent();

  @override
  List<Object> get props => [];
}

final class FetchSupplyDetailsEvent extends SupplyDetailsEvent {
  const FetchSupplyDetailsEvent({required this.supplyId});

  final int supplyId;

  @override
  List<int> get props => [supplyId];
}
