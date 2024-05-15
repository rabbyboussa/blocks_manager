part of 'suppliers_bloc.dart';

sealed class SuppliersEvent extends Equatable {
  const SuppliersEvent();

  @override
  List<Object> get props => [];
}

final class FetchSuppliersEvent extends SuppliersEvent {}

final class SupplierAddedEvent extends SuppliersEvent {
  const SupplierAddedEvent({required this.supplier});

  final SupplierEntity supplier;

  @override
  List<SupplierEntity> get props => [supplier];
}

final class SupplierUpdatedEvent extends SuppliersEvent {
  const SupplierUpdatedEvent({required this.supplier});

  final SupplierEntity supplier;

  @override
  List<Object> get props => [supplier];
}
