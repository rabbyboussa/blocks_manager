part of 'edit_supplier_bloc.dart';

sealed class EditSupplierState extends Equatable {
  const EditSupplierState();

  @override
  List<Object> get props => [];
}

final class EditSupplierInitial extends EditSupplierState {}

final class EditSupplierLoadingState extends EditSupplierState {}

final class EditSupplierFailedState extends EditSupplierState {
  const EditSupplierFailedState({required this.message});

  final String message;

  @override
  List<String> get props => [message];
}

final class EditSupplierDoneState extends EditSupplierState {
  const EditSupplierDoneState({
    required this.supplier,
    this.modification = false,
  });

  final SupplierEntity supplier;
  final bool modification;

  @override
  List<Object> get props => [
        supplier,
        modification,
      ];
}
