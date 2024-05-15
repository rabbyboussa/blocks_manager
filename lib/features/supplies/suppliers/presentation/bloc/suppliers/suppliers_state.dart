part of 'suppliers_bloc.dart';

sealed class SuppliersState extends Equatable {
  const SuppliersState({
    this.suppliers,
    this.message,
  });

  final List<SupplierEntity>? suppliers;
  final String? message;

  @override
  List<Object?> get props => [
        suppliers,
        message,
      ];
}

final class SuppliersInitial extends SuppliersState {}

final class SuppliersFetchingLoadingState extends SuppliersState {}

final class SuppliersFetchingFailedState extends SuppliersState {
  const SuppliersFetchingFailedState({required String message})
      : super(message: message);
}

final class SuppliersFetchingDoneState extends SuppliersState {
  const SuppliersFetchingDoneState({required List<SupplierEntity> suppliers})
      : super(suppliers: suppliers);
}
