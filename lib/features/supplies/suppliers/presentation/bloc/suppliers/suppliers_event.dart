part of 'suppliers_bloc.dart';

sealed class SuppliersEvent extends Equatable {
  const SuppliersEvent();

  @override
  List<Object> get props => [];
}

final class FetchSuppliersEvent extends SuppliersEvent {
  const FetchSuppliersEvent({required this.siteId});

  final int siteId;

  @override
  List<Object> get props => [siteId];
}

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
